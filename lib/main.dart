import 'package:chat_with_us/core/blocs/blocs.dart';
import 'package:chat_with_us/core/blocs/theme/theme_cubit.dart';
import 'package:chat_with_us/core/routes/routes.dart';

import 'package:chat_with_us/core/utils/storage/shared_preference.dart';
import 'package:chat_with_us/core/utils/theme/theme.dart';
import 'package:chat_with_us/features/chat/data/models/chat_model.dart';
import 'package:chat_with_us/features/chat/data/models/chat_session.dart';

import 'package:hive_flutter/hive_flutter.dart';
import 'package:chat_with_us/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:overlay_support/overlay_support.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await SharedPrefrenceHelper.init();
  await Hive.initFlutter();
  Hive.registerAdapter(
    ChatModelAdapter(),
  );
  Hive.registerAdapter(
    ChatSessionAdapter(),
  );
  runApp(const MyWidget());
}

final appRouter = AppRouter();

class MyWidget extends StatelessWidget {
  const MyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: const Size(360, 690),
        child: MultiBlocProvider(
          providers: MultiBlocs.providers,
          child: Builder(
            builder: (context) {
              var themeType = context.watch<ThemeCubit>().state.themeType;
              //  Utility.context = context;
              return OverlaySupport.global(
                child: MaterialApp.router(
                  title: 'Chat With Us',
                  debugShowCheckedModeBanner: false,
                  theme: ThemeUtils.getTheme(themeType),
                  builder: EasyLoading.init(builder: (context, child) {
                    return SafeArea(
                      child: Stack(
                        children: [
                          child!,
                          Positioned(
                            top: 0,
                            right: 0,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: IconButton(
                                icon: Icon(
                                  themeType == ThemeType.light
                                      ? Icons.brightness_4
                                      : Icons.brightness_7,
                                  color: themeType == ThemeType.dark
                                      ? Colors.yellow
                                      : Colors.black,
                                ),
                                onPressed: () {
                                  context.read<ThemeCubit>().toggleTheme();
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  }),
                  routeInformationParser: appRouter.defaultRouteParser(),
                  routerDelegate: appRouter.delegate(
                    navigatorObservers: () => [],
                  ),
                ),
              );
            },
          ),
        ));
  }
}
