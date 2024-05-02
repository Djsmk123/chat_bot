import 'package:chat_with_us/core/utils/storage/shared_preference.dart';
import 'package:chat_with_us/core/utils/theme/theme.dart';

class ThemeState {
  final ThemeType themeType;

  ThemeState({required this.themeType});
  factory ThemeState.initial() {
    var theme = SharedPrefrenceHelper.getString('theme');
    if (theme == 'dark') {
      return ThemeState(themeType: ThemeType.dark);
    }
    return ThemeState(themeType: ThemeType.light);
  }
}
