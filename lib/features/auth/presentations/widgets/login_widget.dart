// ignore_for_file: unnecessary_import

import 'package:chat_with_us/core/utils/theme/theme.dart';
import 'package:chat_with_us/core/utils/toast.dart';
import 'package:chat_with_us/core/utils/validators.dart';
import 'package:chat_with_us/core/widgets/custom_text_field.dart';
import 'package:chat_with_us/core/widgets/primary_button.dart';
import 'package:chat_with_us/features/auth/presentations/blocs/login_cubit.dart';
import 'package:chat_with_us/features/auth/presentations/blocs/login_state.dart';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';

class LoginWidget extends StatelessWidget {
  const LoginWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      bool isMobile = constraints.maxWidth < 600;
      var state = context.watch<LoginCubit>().state;
      bool isLogin = state.loginStatus == LoginStatus.login;

      return Padding(
        padding: EdgeInsets.symmetric(
          horizontal: isMobile ? 20.w : 0.34.sw,
        ),
        child: Column(
          children: [
            if (state.loginStatus == LoginStatus.signup)
              CustomTextField(
                labelText: 'Username',
                hintText: 'Enter your username',
                onChanged: (value) {
                  context.read<LoginCubit>().usernameChanged(value);
                },
                validator: (value) {
                  if (value?.isEmpty == true) {
                    return 'Username is required';
                  }
                  return null;
                },
              ),
            if (state.loginStatus == LoginStatus.signup) SizedBox(height: 20.h),
            CustomTextField(
              labelText: 'Email',
              hintText: 'Enter your email',
              type: TextInputType.emailAddress,
              onChanged: (value) {
                context.read<LoginCubit>().emailChanged(value);
              },
              validator: (value) {
                if (value?.isEmpty == true) {
                  return 'Email is required';
                }
                if (!CustomValidators.emailValidator(value)) {
                  return 'Invalid email';
                }
                return null;
              },
            ),
            SizedBox(height: 20.h),
            CustomTextField(
              labelText: 'Password',
              hintText: 'Enter your password',
              obscureText: state.passwordVisible,
              suffixIcon: IconButton(
                icon: Icon(
                  state.passwordVisible
                      ? Icons.visibility
                      : Icons.visibility_off,
                ),
                onPressed: () {
                  context.read<LoginCubit>().togglePasswordVisibility();
                },
              ),
              onChanged: (value) {
                context.read<LoginCubit>().passwordChanged(value);
              },
              validator: (value) {
                if (value?.isEmpty == true) {
                  return 'Password is required';
                }
                if (isLogin && !CustomValidators.passwordValidator(value)) {
                  return 'Password must be at least 6 characters ';
                }
                return null;
              },
            ),
            SizedBox(height: 20.h),
            CustomRoundedButton(
              onTap: () {
                if (!context
                    .read<LoginCubit>()
                    .formKey
                    .currentState!
                    .validate()) {
                  Utility.showToast(
                    'Please fill the field',
                    ToastType.error,
                  );
                  return;
                }

                switch (state.loginStatus) {
                  case LoginStatus.login:
                    {
                      context.read<LoginCubit>().login();
                      break;
                    }
                  case LoginStatus.signup:
                    {
                      context.read<LoginCubit>().signup();
                      break;
                    }
                  case LoginStatus.forgotPassword:
                    {
                      context.read<LoginCubit>().forgotPassword();
                      break;
                    }
                }
              },
              backgroundColor:
                  context.isDarkMode() ? Colors.white : context.primaryColor,
              width: 1.sw,
              child: Text(
                'Login',
                style: context.textTheme.copyWith(
                  color: context.isDarkMode() ? Colors.black : Colors.white,
                  fontSize: context.fontSize(12),
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            SizedBox(height: 20.h),
            if (state.loginStatus == LoginStatus.login)
              Align(
                alignment: Alignment.centerRight,
                child: InkWell(
                  onTap: () {
                    context.read<LoginCubit>().toggleLoginStatus(
                          isLogin ? LoginStatus.signup : LoginStatus.login,
                        );
                  },
                  child: Text(
                    'Forgot password?',
                    style: context.textTheme.copyWith(
                      fontSize: context.fontSize(12),
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ),
            if (state.loginStatus == LoginStatus.login) SizedBox(height: 20.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  isLogin
                      ? 'Don\'t have an account?'
                      : 'Already have an account?',
                  style: context.textTheme.copyWith(
                    fontSize: context.fontSize(12),
                    fontWeight: FontWeight.w400,
                  ),
                ),
                SizedBox(width: 2.w),
                InkWell(
                  onTap: () {
                    context.read<LoginCubit>().toggleLoginStatus(
                          isLogin ? LoginStatus.signup : LoginStatus.login,
                        );
                  },
                  child: Text(
                    state.loginStatus == LoginStatus.login
                        ? 'Login'
                        : state.loginStatus == LoginStatus.signup
                            ? 'Sign up'
                            : 'Forgot password',
                    style: context.textTheme.copyWith(
                      fontSize: context.fontSize(12),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 20.h),
          ],
        ),
      );
    });
  }
}
