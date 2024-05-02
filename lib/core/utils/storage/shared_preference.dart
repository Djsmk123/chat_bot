import 'package:chat_with_us/core/models/result.dart';
import 'package:chat_with_us/core/utils/error/error_code.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefrenceHelper {
  static late SharedPreferences _sharedPreferences;
  static Future<Result<bool>> init() async {
    try {
      _sharedPreferences = await SharedPreferences.getInstance();
      return const Success(data: true);
    } catch (e) {
      return Failure(
        errorType: ClientSideException(
          code: ErrorCode.storageError,
        ),
        details: e.toString(),
      );
    }
  }

  static Future<Result<bool>> setValue(String key, String value) async {
    try {
      await _sharedPreferences.setString(key, value);
      return const Success(data: true);
    } catch (e) {
      throw Failure(
        errorType: ClientSideException(
          code: ErrorCode.storageError,
        ),
        details: e.toString(),
      );
    }
  }

  static String? getString(String key) {
    return _sharedPreferences.getString(key);
  }
}
