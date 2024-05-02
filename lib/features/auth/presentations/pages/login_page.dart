import 'package:auto_route/auto_route.dart';
import 'package:chat_with_us/core/utils/theme/theme.dart';
import 'package:chat_with_us/features/auth/presentations/blocs/login_cubit.dart';
import 'package:chat_with_us/features/auth/presentations/blocs/login_state.dart';
import 'package:chat_with_us/features/auth/presentations/widgets/login_widget.dart';
import 'package:chat_with_us/gen/assets.gen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';

@RoutePage()
class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<LoginCubit>(
      create: (context) => LoginCubit(),
      child: PopScope(
        canPop: false,
        onPopInvoked: (canPop) {
          // var provider = context.read<LoginCubit>();
          // if (provider.state.loginStatus != LoginStatus.login) {
          //   provider.toggleLoginStatus(LoginStatus.login);
          // }
        },
        child: Scaffold(
          body: SingleChildScrollView(
            child: Builder(builder: (context) {
              var state = context.watch<LoginCubit>().state;
              return Form(
                key: context.read<LoginCubit>().formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Hero(
                        tag: 'logo',
                        child: Assets.images.splash.lottie(
                          fit: BoxFit.cover,
                        )),
                    SizedBox(height: 20.h),
                    Center(
                      child: Text(
                        'Welcome to Talk-Bot',
                        style: context.textTheme.copyWith(
                          fontSize: context.fontSize(20),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    SizedBox(height: 20.h),
                    Text(
                      state.loginStatus == LoginStatus.login
                          ? 'Login to continue'
                          : state.loginStatus == LoginStatus.signup
                              ? 'Sign up to continue'
                              : 'Forgot password',
                      style: context.textTheme.copyWith(
                        fontSize: context.fontSize(16),
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    SizedBox(height: 20.h),
                    const LoginWidget()
                  ],
                ),
              );
            }),
          ),
        ),
      ),
    );
  }
}
