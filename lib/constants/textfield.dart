import 'package:chat/constants/sizes.dart';
import 'package:flutter/material.dart';

import 'colors.dart';

const kTextInputDecoration = InputDecoration(
  labelStyle: TextStyle(
    color: AppColors.appText,
  ),
  hintStyle: TextStyle(
    color: AppColors.appText,
  ),
  border: InputBorder.none,
  contentPadding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
  enabledBorder: OutlineInputBorder(
    borderSide: BorderSide(color: AppColors.indyBlue),
    borderRadius: BorderRadius.all(Radius.circular(12)),
  ),
  focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(color: AppColors.indyBlue),
    borderRadius: BorderRadius.all(Radius.circular(12)),
  ),
  errorBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.red),
    borderRadius: BorderRadius.all(
      Radius.circular(Sizes.dimen_10),
    ),
  ),
  focusedErrorBorder: OutlineInputBorder(
    borderRadius: BorderRadius.all(
      Radius.circular(Sizes.dimen_10),
    ),
  ),
);

const Widget vertical5 = SizedBox(height: 5.0);
const Widget vertical10 = SizedBox(height: 10.0);
const Widget vertical15 = SizedBox(height: 15.0);
const Widget vertical20 = SizedBox(height: 20.0);

const Widget vertical25 = SizedBox(height: 25.0);
const Widget vertical30 = SizedBox(height: 30.0);

const Widget vertical50 = SizedBox(height: 50.0);
const Widget vertical120 = SizedBox(height: 120.0);

const Widget horizontal5 = SizedBox(width: 5.0);
const Widget horizontal10 = SizedBox(width: 10.0);
const Widget horizontal15 = SizedBox(width: 15.0);
const Widget horizontal20 = SizedBox(width: 20.0);
const Widget horizontal25 = SizedBox(width: 25.0);
const Widget horizontal30 = SizedBox(width: 30.0);
const Widget horizontal50 = SizedBox(width: 50.0);
const Widget horizontal100 = SizedBox(width: 100.0);
const Widget horizontal120 = SizedBox(width: 120.0);
