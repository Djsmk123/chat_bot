import 'package:chat_with_us/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:overlay_support/overlay_support.dart';

enum ToastType { success, error, warning, info }

class Utility {
  //use simple notification
  BuildContext context = appRouter.navigatorKey.currentContext!;
  static void showToast(String message, ToastType type) {
    Color color;
    switch (type) {
      case ToastType.success:
        color = Colors.green;
        break;
      case ToastType.error:
        color = Colors.red;
        break;
      case ToastType.warning:
        color = Colors.orange;
        break;
      case ToastType.info:
        color = Colors.blue;
        break;
    }
    showSimpleNotification(
      Row(
        children: [
          Icon(
            type == ToastType.success
                ? Icons.check_circle
                : type == ToastType.error
                    ? Icons.error
                    : type == ToastType.warning
                        ? Icons.warning
                        : Icons.info,
            color: Colors.white,
          ),
          SizedBox(width: 10.w),
          Text(
            message,
            style: const TextStyle(color: Colors.white),
          ),
        ],
      ),
      background: color,
      autoDismiss: true,
      duration: const Duration(seconds: 2),
    );
  }
}
