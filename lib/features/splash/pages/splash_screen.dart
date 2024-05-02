// ignore_for_file: unnecessary_import

import 'package:auto_route/auto_route.dart';
import 'package:chat_with_us/core/routes/routes.gr.dart';
import 'package:chat_with_us/features/auth/data/repo/auth_services.dart';
import 'package:chat_with_us/gen/assets.gen.dart';
import 'package:flutter/material.dart';

import 'package:flutter/widgets.dart';

@RoutePage()
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Future.delayed(const Duration(seconds: 2), () {
        bool isAuthenticated = AuthService.isAuthenticated;
        if (isAuthenticated) {
          context.router.replace(const ChatScreen());
        } else {
          context.router.replace(const LoginScreen());
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
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
