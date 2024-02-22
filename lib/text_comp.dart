import 'dart:math';
import 'package:flutter/material.dart';
import 'dart:ui';

import 'package:nb_utils/nb_utils.dart';

class TextModel extends StatelessWidget {
  final String title;
  double? width;
  Color? backgroundColor;
  String? image;

  TextModel(
      {super.key,
      required this.title,
      this.width,
      this.image,
      this.backgroundColor});
  @override
  Widget build(BuildContext context) {
    return Container(
        alignment: Alignment.center,
        width: width,
        height: 40,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Color(0xFF7EF6F0),
                spreadRadius: 0,
                blurRadius: 10,
                offset: Offset(0, 0),
              ),
            ],
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
          child: image == 'none'
              ? Text(
                  title,
                  style: TextStyle(fontSize: 14, color: Colors.white),
                )
              : Stack(
                  children: [
                    Image.asset('assets/image/playing.png'),
                    Positioned(
                      top: -5,
                      left: -20,
                      child: IconButton(
                          onPressed: () {},
                          icon: Image.asset('assets/image/Play.png')),
                    )
                  ],
                ),
        ));
  }
}
