import 'package:flutter/material.dart';
import 'package:flutterapp1/utils/app_layout.dart';
import 'package:flutterapp1/utils/app_styles.dart';

final textInputDecoration = InputDecoration(
  contentPadding: EdgeInsets.only(top: AppLayout.getHeight(14)),
  hintStyle: Styles.textStyle1.copyWith(fontSize: 15, color: Colors.grey),
  enabledBorder: OutlineInputBorder(
    borderRadius: BorderRadius.circular(20),
    borderSide: const BorderSide(width: 1, color: Colors.white),
  ),
  focusedBorder: OutlineInputBorder(
    borderRadius: BorderRadius.circular(20),
    borderSide: const BorderSide(color: Colors.white, width: 1),
  ),
);

final boxDecoration = BoxDecoration(
    color: Colors.white,
    borderRadius: BorderRadius.circular(20),
    boxShadow: const [
      BoxShadow(
        color: Colors.grey,
        blurRadius: 2.5,
        spreadRadius: 1.5,
      )
    ]);
