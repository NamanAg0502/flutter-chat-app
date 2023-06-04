import 'package:chat/constants/index.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';

class SelectCountryCode extends StatelessWidget {
  const SelectCountryCode({
    Key? key,
    required this.onChanged,
  }) : super(key: key);

  final Function(CountryCode) onChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      // alignment: Alignment.centerLeft,
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.appBg2),
        borderRadius: BorderRadius.circular(12),
      ),
      child: CountryCodePicker(
        closeIcon: const Icon(
          Icons.close,
          color: AppColors.appText,
        ),
        padding: const EdgeInsets.symmetric(horizontal: 8),
        textStyle: const TextStyle(
          color: AppColors.appText,
          fontSize: 14,
          fontWeight: FontWeight.w500,
        ),
        backgroundColor: AppColors.appNav,
        flagDecoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4),
        ),
        boxDecoration: const BoxDecoration(
          color: AppColors.appNav,
          shape: BoxShape.rectangle,
          // borderRadius: BorderRadius.circular(12),
        ),
        dialogSize: const Size(350, 500),
        dialogTextStyle: const TextStyle(
          color: AppColors.appText,
          fontSize: 14,
          fontWeight: FontWeight.w500,
        ),
        searchDecoration: InputDecoration(
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
          hintText: 'Search',
          hintStyle: const TextStyle(
            color: AppColors.appText,
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
          labelStyle: const TextStyle(
            color: AppColors.appText,
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(
              color: AppColors.appBg2,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(
              color: AppColors.appBg2,
            ),
          ),
          prefixIconColor: AppColors.appText,
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(
              color: AppColors.appBg2,
            ),
          ),
        ),
        dialogBackgroundColor: AppColors.appNav,
        onChanged: onChanged,
        initialSelection: 'IN',
        showCountryOnly: false,
        showOnlyCountryWhenClosed: false,
        favorite: const ["+1", "US", "+91", "IN"],
      ),
    );
  }
}
