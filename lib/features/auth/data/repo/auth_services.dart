import 'package:chat_with_us/core/models/result.dart';
import 'package:chat_with_us/core/utils/error/error_code.dart';

import 'package:chat_with_us/features/auth/data/models/user_model.dart';
import 'package:chat_with_us/features/chat/data/repo/chat_repo.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  static final FirebaseAuth _auth = FirebaseAuth.instance;
  static bool get isAuthenticated {
    return _auth.currentUser != null;
  }

  static UserModel? user;

  static void setUser() {
    var firebaseUser = _auth.currentUser;
    if (firebaseUser != null) {
      user = UserModel(
        email: firebaseUser.email ?? '',
        id: firebaseUser.uid,
        username: firebaseUser.displayName ?? '',
      );
    }
  }

  static Future<Result<UserModel>> login(String email, String password) async {
    try {
      await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      setUser();
      if (user == null) {
        return Failure(
          errorType: ClientSideException(
            code: ErrorCode.endPointError,
            message: 'User not found',
          ),
          details: 'User not found',
        );
      }
      return Success(data: user!);
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case 'invalid-credential':
          return Failure(
            errorType: ClientSideException(
              code: ErrorCode.endPointError,
              message: 'Please check your credentials',
            ),
            details: e.toString(),
          );
        case 'user-not-found':
          return Failure(
            errorType: ClientSideException(
              code: ErrorCode.endPointError,
              message: 'User not found',
            ),
            details: e.toString(),
          );
        case 'wrong-password':
          return Failure(
            errorType: ClientSideException(
              code: ErrorCode.endPointError,
              message: 'Wrong password',
            ),
            details: e.toString(),
          );
        default:
          return Failure(
            errorType: ClientSideException(
                code: ErrorCode.endPointError, message: 'Unexpected error'),
            details: e.toString(),
          );
      }
    }
  }

  static Future<Result<UserModel>> signup(
      String email, String password, String username) async {
    try {
      var userCredential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      await userCredential.user?.updateDisplayName(username);

      setUser();
      if (user == null) {
        return Failure(
          errorType: ClientSideException(
            code: ErrorCode.endPointError,
            message: 'User not found',
          ),
          details: 'User not found',
        );
      }
      return Success(data: user!);
    } on FirebaseAuthException catch (e) {
      return Failure(
        errorType: ClientSideException(
          code: ErrorCode.endPointError,
          message: e.message?.toString(),
        ),
        details: e.message!,
      );
    }
  }

  static Future<Result<bool>> logout() async {
    try {
      await _auth.signOut();
      await ChatRepo.disconnect();
      await ChatRepo.deleteAllChatSession();
      return const Success(data: true);
    } on FirebaseAuthException catch (e) {
      return Failure(
        errorType: ClientSideException(
          code: ErrorCode.endPointError,
          message: e.message?.toString(),
        ),
        details: e.message!,
      );
    }
  }

  static Future<Result<bool>> forgotPassword(String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
      return const Success(data: true);
    } on FirebaseAuthException catch (e) {
      return Failure(
        errorType: ClientSideException(
          code: ErrorCode.endPointError,
          message: e.message?.toString(),
        ),
        details: e.message!,
      );
    }
  }
}
