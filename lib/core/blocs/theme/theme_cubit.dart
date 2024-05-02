import 'package:chat_with_us/core/blocs/theme/theme_state.dart';
import 'package:chat_with_us/core/utils/storage/shared_preference.dart';
import 'package:chat_with_us/core/utils/theme/theme.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ThemeCubit extends Cubit<ThemeState> {
  ThemeCubit() : super(ThemeState.initial());

  Future<void> toggleTheme() async {
    var themeType =
        state.themeType == ThemeType.light ? ThemeType.dark : ThemeType.light;
    await SharedPrefrenceHelper.setValue(
        'theme', themeType == ThemeType.light ? 'light' : 'dark');
    emit(ThemeState(
      themeType: themeType,
    ));
  }
}
