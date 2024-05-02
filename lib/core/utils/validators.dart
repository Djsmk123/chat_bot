import 'package:intl/intl.dart';

class CustomValidators {
  static bool emailValidator(String? value) {
    if (value == null || value.isEmpty) {
      return false;
    }
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    return emailRegex.hasMatch(value);
  }

  static bool passwordValidator(String? value) {
    if (value == null || value.isEmpty) {
      return false;
    }

    return value.length >= 6;
  }

  static bool validUsername(String? value) {
    if (value == null || value.isEmpty) {
      return false;
    }
    final usernameRegex = RegExp(r'^[a-zA-Z0-9_]{3,30}$');
    return usernameRegex.hasMatch(value);
  }
}

extension DateTimeExt on DateTime {
  // Returns a formatted string of the date in am/pm format
  String get formattedDate {
    return DateFormat('hh:mm a').format(this);
  }
}
