// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i4;
import 'package:chat_with_us/features/auth/presentations/pages/login_page.dart'
    as _i2;
import 'package:chat_with_us/features/chat/presentations/chat_screen.dart'
    as _i1;
import 'package:chat_with_us/features/splash/pages/splash_screen.dart' as _i3;

abstract class $AppRouter extends _i4.RootStackRouter {
  $AppRouter({super.navigatorKey});

  @override
  final Map<String, _i4.PageFactory> pagesMap = {
    ChatScreen.name: (routeData) {
      return _i4.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i1.ChatScreen(),
      );
    },
    LoginScreen.name: (routeData) {
      return _i4.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i2.LoginScreen(),
      );
    },
    SplashScreen.name: (routeData) {
      return _i4.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i3.SplashScreen(),
      );
    },
  };
}

/// generated route for
/// [_i1.ChatScreen]
class ChatScreen extends _i4.PageRouteInfo<void> {
  const ChatScreen({List<_i4.PageRouteInfo>? children})
      : super(
          ChatScreen.name,
          initialChildren: children,
        );

  static const String name = 'ChatScreen';

  static const _i4.PageInfo<void> page = _i4.PageInfo<void>(name);
}

/// generated route for
/// [_i2.LoginScreen]
class LoginScreen extends _i4.PageRouteInfo<void> {
  const LoginScreen({List<_i4.PageRouteInfo>? children})
      : super(
          LoginScreen.name,
          initialChildren: children,
        );

  static const String name = 'LoginScreen';

  static const _i4.PageInfo<void> page = _i4.PageInfo<void>(name);
}

/// generated route for
/// [_i3.SplashScreen]
class SplashScreen extends _i4.PageRouteInfo<void> {
  const SplashScreen({List<_i4.PageRouteInfo>? children})
      : super(
          SplashScreen.name,
          initialChildren: children,
        );

  static const String name = 'SplashScreen';

  static const _i4.PageInfo<void> page = _i4.PageInfo<void>(name);
}
