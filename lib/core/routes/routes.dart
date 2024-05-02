import 'package:chat_with_us/core/routes/routes.gr.dart';
import 'package:chat_with_us/core/routes/routes_guards.dart';
import 'package:flutter/material.dart';

import 'package:auto_route/auto_route.dart';

@AutoRouterConfig(replaceInRouteName: 'Page,Router')
class AppRouter extends $AppRouter {
  AppRouter() : super();
  @override
  RouteType get defaultRouteType => RouteType.custom(
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return FadeTransition(
            opacity: animation,
            child: child,
          );
        },
      ); //.cupertino, .adaptive ..etc

  @override
  final List<AutoRoute> routes = <CustomRoute>[
    CustomRoute(
      path: '/splash',
      page: SplashScreen.page,
      initial: true,
    ),
    CustomRoute(
      path: '/auth',
      page: LoginScreen.page,
    ),
    CustomRoute(path: '/chat', page: ChatScreen.page, guards: [
      AuthGuard(),
    ]),
  ];
}
