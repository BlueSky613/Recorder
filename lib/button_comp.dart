import 'dart:math';
import 'package:flutter/material.dart';
import 'dart:ui';

import 'package:nb_utils/nb_utils.dart';

class SelectButton extends StatelessWidget {
  final Function()? onPressed;
  final String title;
  double? width;
  Color? backgroundColor;
  String? prefix;

  SelectButton(
      {super.key,
      this.onPressed,
      required this.title,
      this.width,
      this.prefix,
      this.backgroundColor});
  @override
  Widget build(BuildContext context) {
    return Container(
        alignment: Alignment.center,
        width: width,
        height: 40,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            gradient: LinearGradient(
                colors: [Color(0xFF021D5A), Color(0xFF4CA7E8)],
                begin: Alignment.centerLeft,
                end: Alignment.centerRight)),
        child: Container(
          alignment: Alignment.center,
          width: width! - 4,
          height: 36,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(18),
            color: Color(0xFF010314),
          ),
          child: OutlinedButton(
              style: OutlinedButton.styleFrom(
                backgroundColor: Color(0xFF010314),
                side: BorderSide(
                    style: BorderStyle.solid,
                    color: Colors.transparent,
                    width: 1.5),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18)),
              ),
              onPressed: onPressed,
              child: Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    prefix == 'google' ? Image.asset(
                      'assets/image/google.png',
                      width: 20,
                    ): prefix == 'apple' ? Image.asset(
                      'assets/image/apple.png',
                      width: 25,
                    ): Container(width: 0,),
                  Container(
                    alignment: Alignment.center,
                    child:                     Text(
                      title,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 18,
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                    ),
                  )
                  ],
                ),
              )),
        ));
  }
}
