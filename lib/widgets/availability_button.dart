// ignore_for_file: must_be_immutable, unused_import, use_key_in_widget_constructors, prefer_const_constructors

import 'package:flutter/material.dart';

import '../brand_colors.dart';

class AvailabilityButton extends StatelessWidget {
  String title;
  Color color;
  Function onPressed;
  AvailabilityButton({this.title, this.onPressed, this.color});
  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(25),
      ),
      color: color,
      textColor: Colors.white,
      child: Container(
        height: 50,
        width: 200,
        child: Center(
          child: Text(
            title,
            style: TextStyle(fontSize: 20, fontFamily: 'Brand-Bold'),
          ),
        ),
      ),
      onPressed: onPressed,
    );
  }
}
