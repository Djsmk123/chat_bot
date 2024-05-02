// ignore_for_file: must_be_immutable

import 'package:chat_with_us/core/utils/theme/theme.dart';
import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    required this.labelText,
    super.key,
    this.style,
    this.hintText,
    this.obscureText = false,
    this.onChanged,
    this.initialValue,
    this.validator,
    this.focusNode,
    this.type = TextInputType.text,
    this.isValid = true,
    this.autoValidateMode,
    this.suffixIcon,
    this.onSubmit,
    this.controller,
  });
  final String labelText;
  final TextStyle? style;
  final TextInputType type;
  final String? hintText;
  final FocusNode? focusNode;
  final bool obscureText;
  final bool isValid;
  final Widget? suffixIcon;
  final TextEditingController? controller;
  final AutovalidateMode? autoValidateMode;
  final String? Function(String? value)? validator;
  final Function(String? value)? onSubmit;
  final void Function(String)? onChanged;
  final String? initialValue;

  @override
  Widget build(BuildContext context) {
    return TapRegion(
      onTapOutside: (event) {},
      child: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              offset: const Offset(12, 26),
              blurRadius: 50,
              color: Colors.grey.withOpacity(.1),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (!isValid)
              Text(
                '$labelText *',
                style: TextStyle(
                  color: const Color(0XFFFE2424),
                  fontSize: context.fontSize(14),
                  fontWeight: FontWeight.bold,
                ),
              ),
            if (!isValid)
              SizedBox(
                height: 8.h,
              ),
            TextFormField(
              key: ValueKey(initialValue),
              initialValue: initialValue,
              focusNode: focusNode,
              controller: controller,
              autovalidateMode: autoValidateMode,
              obscureText: obscureText,
              onChanged: onChanged,
              validator: validator,
              onFieldSubmitted: (value) {
                //close keyboard first
                FocusManager.instance.primaryFocus?.unfocus();
                onSubmit?.call(value);
              },
              keyboardType: type,
              style: style ?? context.textTheme.copyWith(),
              decoration: InputDecoration(
                hintText: hintText,
                hintStyle: context.textTheme.copyWith(
                  color: Colors.grey.shade500,
                  fontWeight: FontWeight.w500,
                  fontSize: context.fontSize(14),
                ),
                suffixIcon: suffixIcon,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(
                    color: Colors.grey.shade300,
                  ),
                ),
                errorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(
                    color: Color(0XFFFE2424),
                  ),
                ),
                errorStyle: TextStyle(
                  color: const Color(0XFFFE2424),
                  fontSize: context.fontSize(12),
                  fontWeight: FontWeight.bold,
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(color: context.primaryColor),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
