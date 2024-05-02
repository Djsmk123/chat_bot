import 'package:chat_with_us/core/utils/theme/theme.dart';
import 'package:chat_with_us/gen/assets.gen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class EmptyChatWidget extends StatelessWidget {
  final bool isLoading;
  const EmptyChatWidget({super.key, required this.isLoading});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Assets.images.splash.lottie(
            height: 150.h,
          ),
          SizedBox(height: 20.h),
          Text(
            'How Can I Help You?',
            style: context.textTheme.copyWith(
              fontSize: context.fontSize(20),
            ),
          ),
          SizedBox(height: 20.h),
          if (isLoading)
            const Center(
              child: CircularProgressIndicator(),
            ),
        ],
      ),
    );
  }
}
