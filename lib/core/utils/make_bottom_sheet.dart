import 'package:flutter/material.dart';

void makeBtmSheet(BuildContext context, Widget child) {
  showModalBottomSheet(
      shape: RoundedRectangleBorder(
        //the rounded corner is created here
        borderRadius: BorderRadius.circular(10.0),
      ),
      context: context,
      builder: (context) {
        return child;
      });
}
