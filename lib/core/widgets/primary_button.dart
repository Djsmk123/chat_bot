import 'package:chat_with_us/core/utils/theme/theme.dart';
import 'package:chat_with_us/core/widgets/boucing_widget.dart';
import 'package:flutter/material.dart';

class CustomRoundedButton extends StatelessWidget {
  const CustomRoundedButton({
    required this.child,
    super.key,
    this.onTap,
    this.width = 120,
    this.nonBoundedHeight = false,
    this.height = 50,
    this.isEnable = true,
    this.backgroundColor,
    this.border,
    this.borderRadius,
    this.gradient,
    this.isLoading = false,
  });
  final Widget child;
  final double width;
  final double height;
  final bool isEnable;
  final Color? backgroundColor;
  final Function()? onTap;
  final Border? border;
  final bool nonBoundedHeight;
  final LinearGradient? gradient;
  final bool isLoading;
  final BorderRadius? borderRadius;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: isEnable ? onTap : null,
      child: Center(
          child: container(
        context,
      )),
    );
  }

  BouncingWidget container(BuildContext context) => BouncingWidget(
        onTap: onTap,
        child: Container(
          width: width,
          height: !nonBoundedHeight ? height : null,
          decoration: BoxDecoration(
            borderRadius: borderRadius ?? BorderRadius.circular(32),
            color: (gradient != null
                ? null
                : (isEnable ? backgroundColor : Colors.grey.shade500)),
            border: border,
            gradient: gradient,
          ),
          child: Center(
            child: !isLoading
                ? child
                : CircularProgressIndicator.adaptive(
                    valueColor:
                        AlwaysStoppedAnimation<Color>(context.primaryColor),
                  ),
          ),
        ),
      );
}
