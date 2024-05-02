// ignore_for_file: unnecessary_import

import 'package:auto_route/auto_route.dart';
import 'package:chat_with_us/core/routes/routes.gr.dart';
import 'package:chat_with_us/features/auth/data/repo/auth_services.dart';
import 'package:chat_with_us/gen/assets.gen.dart';
import 'package:flutter/material.dart';

import 'package:flutter/widgets.dart';

@RoutePage()
class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Future.delayed(const Duration(seconds: 2), () {
      bool isAuthenticated = AuthService.isAuthenticated;
      if (isAuthenticated) {
        context.router.replace(const ChatScreen());
      } else {
        context.router.replace(const LoginScreen());
      }
    });
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Hero(tag: 'logo', child: Assets.images.splash.lottie()),
          ],
        ),
      ),
    );
  }
}
