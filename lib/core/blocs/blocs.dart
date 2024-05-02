// ignore_for_file: depend_on_referenced_packages

import 'package:chat_with_us/core/blocs/theme/theme_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/single_child_widget.dart';

class MultiBlocs {
  static List<SingleChildWidget> get providers => [
        BlocProvider<ThemeCubit>(
          create: (context) => ThemeCubit(),
        ),
      ];
}
