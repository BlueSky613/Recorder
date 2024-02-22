import 'dart:math';
import 'package:flutter/material.dart';
import 'dart:ui';

import 'package:nb_utils/nb_utils.dart';

class Circlebutton extends StatelessWidget {
  final Function()? onPressed;
  Circlebutton({super.key, this.onPressed});
  @override
  Widget build(BuildContext context) {
    return Container(
        alignment: Alignment.topCenter,
        width: 50,
        height: 50,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25),
          color: Color(0xFF7EE8F6).withOpacity(0.57),
          // boxShadow: [
          //     BoxShadow(
          //       color: Color(0xFF7EF6F0),
          //       spreadRadius: 0,
          //       blurRadius: 4,
          //       offset: Offset(0, 0),
          //     ),
          //   ]
        ),
        child: Container(
          alignment: Alignment.center,
          width: 46,
          height: 46,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(23),
            color: Color(0xFF010314),
          ),
          child: OutlinedButton(
              style: OutlinedButton.styleFrom(
                backgroundColor: Color(0xFF010314),
                side:BorderSide.none,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(23)),
              ),
              onPressed: onPressed,
              child: Container(
                alignment: Alignment.center,
                child: Text(
                  '>',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                      fontWeight: FontWeight.bold),
                ),
              )),
        ));
  }
}
