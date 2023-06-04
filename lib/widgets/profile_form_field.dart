import 'package:flutter/material.dart';

import '../constants/index.dart';

class ProfileFormField extends StatelessWidget {
  const ProfileFormField({
    Key? key,
    required this.label,
    required this.hintText,
    required this.onChanged,
    this.controller,
    this.focusNode,
    this.prefix,
    this.maxLength,
    this.maxLines,
    this.keyboardType,
  }) : super(key: key);

  final String label;
  final String hintText;
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final Widget? prefix;
  final int? maxLength;
  final int? maxLines;
  final TextInputType? keyboardType;
  final Function(String) onChanged;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        TextField(
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.symmetric(
              horizontal: Sizes.px,
              vertical: Sizes.px,
            ),
            labelText: label,
            labelStyle: const TextStyle(
              color: AppColors.appText,
              fontSize: 14,
            ),
            focusedBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: AppColors.appText),
                borderRadius: BorderRadius.circular(12)),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: AppColors.appText),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: AppColors.appBg2),
            ),
          ),
          cursorColor: AppColors.appBg2,
          style: const TextStyle(color: AppColors.appText, fontSize: 14),
          controller: controller,
          onChanged: onChanged,
          focusNode: focusNode,
          keyboardType: keyboardType,
          maxLines: maxLines ?? 1,
        ),
      ],
    );
  }
}
