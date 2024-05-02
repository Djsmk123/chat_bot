import 'package:chat_with_us/core/models/result.dart';
import 'package:chat_with_us/core/routes/routes.gr.dart';
import 'package:chat_with_us/core/utils/toast.dart';
import 'package:chat_with_us/features/auth/data/models/user_model.dart';
import 'package:chat_with_us/features/auth/data/repo/auth_services.dart';
import 'package:chat_with_us/features/auth/presentations/blocs/login_state.dart';
import 'package:chat_with_us/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class LoginCubit extends Cubit<LoginState> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  LoginCubit() : super(LoginState.initial());

  Future<void> login() async {
    EasyLoading.show(status: 'Logging in...');
    final res =
        await AuthService.login(state.email ?? '', state.password ?? '');
    EasyLoading.dismiss();
    if (res is Success<UserModel>) {
      Utility.showToast(
        'Login successful',
        ToastType.success,
      );
      appRouter.pushAndPopUntil(
        const ChatScreen(),
        predicate: (predicate) => false,
      );
    } else {
      Utility.showToast(
        (res as Failure).message,
        ToastType.error,
      );
    }
  }

  Future<void> signup() async {
    EasyLoading.show(status: 'Signing up...');
    final res = await AuthService.signup(
      state.email ?? '',
      state.password ?? '',
      state.username ?? '',
    );

    EasyLoading.dismiss();

    if (res is Success<UserModel>) {
      Utility.showToast(
        'Signup successful',
        ToastType.success,
      );
      appRouter.pushAndPopUntil(
        const ChatScreen(),
        predicate: (predicate) => false,
      );
    } else {
      Utility.showToast(
        (res as Failure).message,
        ToastType.error,
      );
    }
  }

  Future<void> forgotPassword() async {
    EasyLoading.show(status: 'Sending email...');
    final res = await AuthService.forgotPassword(state.email ?? '');
    EasyLoading.dismiss();
    if (res is Success<bool>) {
      Utility.showToast(
        'Email has been sent to reset password',
        ToastType.success,
      );
    } else {
      Utility.showToast(
        (res as Failure).message,
        ToastType.error,
      );
    }
  }

  void toggleLoginStatus(LoginStatus loginStatus) {
    emit(state.copyWith(loginStatus: loginStatus));
  }

  void emailChanged(String email) {
    emit(state.copyWith(email: email));
  }

  void passwordChanged(String password) {
    emit(state.copyWith(password: password));
  }

  void usernameChanged(String username) {
    emit(state.copyWith(username: username));
  }

  void togglePasswordVisibility() {
    emit(state.copyWith(passwordVisible: !state.passwordVisible));
  }
}
