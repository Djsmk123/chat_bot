import 'package:chat_with_us/core/blocs/theme/theme_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

enum ThemeType {
  light,
  dark;
}

class ThemeUtils {
  static ThemeData getTheme(ThemeType themeType) {
    switch (themeType) {
      case ThemeType.light:
        return ThemeData.light().copyWith(
          primaryColor: Colors.blue,
          scaffoldBackgroundColor: Colors.white,
          appBarTheme: const AppBarTheme(
            color: Colors.white,
            iconTheme: IconThemeData(color: Colors.black),
          ),
        );
      case ThemeType.dark:
        return ThemeData.dark().copyWith(
          primaryColor: Colors.blue,
          scaffoldBackgroundColor: Colors.black,
          appBarTheme: const AppBarTheme(
            color: Colors.black,
            iconTheme: IconThemeData(color: Colors.white),
          ),
        );
      default:
        return ThemeData.light();
    }
  }
}

extension BuildContextX on BuildContext {
  ThemeData get theme => Theme.of(this);
  double fontSize(double size) {
    bool isMobile = MediaQuery.of(this).size.width < 600;
    return isMobile ? size.sp : size;
  }

  TextStyle get textTheme {
    var themeType = watch<ThemeCubit>().state.themeType;
    switch (themeType) {
      case ThemeType.light:
        return const TextStyle(color: Colors.black);
      case ThemeType.dark:
        return const TextStyle(color: Colors.white);
      default:
        return const TextStyle(color: Colors.black);
    }
  }

  Color get primaryColor {
    var themeType = watch<ThemeCubit>().state.themeType;
    switch (themeType) {
      case ThemeType.light:
        return Colors.black;
      case ThemeType.dark:
        return Colors.yellow;
      default:
        return Colors.blue;
    }
  }

  bool isDarkMode() {
    var themeType = read<ThemeCubit>().state.themeType;
    return themeType == ThemeType.dark;
  }

  Size get screenSize => MediaQuery.of(this).size;
}
