import 'dart:math';
import 'package:flutter/material.dart';
import 'dart:ui';

import 'package:nb_utils/nb_utils.dart';

class Slidermodel extends StatefulWidget {
  final String title;
  double? width;
  Color? backgroundColor;
  String? image;
  int? value;

  Slidermodel(
      {super.key,
      required this.title,
      this.width,
      this.image,
      this.value,
      this.backgroundColor});
  @override
  State<Slidermodel> createState() => _Slidermodel();
}

class _Slidermodel extends State<Slidermodel> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.title,
            style: TextStyle(color: Colors.white, fontSize: 16),
          ),
          5.height,
          Container(
              alignment: Alignment.center,
              width: widget.width,
              height: 20,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
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
                width: widget.width! - 4,
                height: 16,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                ),
                child: SliderTheme(
                    data: SliderThemeData(
                      trackHeight: 16,
                      // thumbShape:
                      //     RoundSliderThumbShape(enabledThumbRadius: 10),
                      overlayColor: Colors.transparent,
                    ),
                    child: Stack(
                      children: [
                        Container(
                            alignment: Alignment.center,
                            width: widget.width! - 4,
                            height: 16,
                            decoration: BoxDecoration(
                              color: Colors.transparent
                            )),
                        Slider(
                            value: widget.value!.toDouble(),
                            min: 0,
                            inactiveColor: Color(0xFF010314),
                            thumbColor: Colors.white,
                            activeColor: Colors.transparent,
                            max: 20,
                            onChanged: (double newValue) {
                              setState(() {
                                widget.value = newValue.round();
                              });
                            }),
                        widget.value != 0 ? Positioned(
                          top: 0,
                          left: 10,
                          child: Text(
                            widget.value.toString(),
                            style: TextStyle(color: Colors.white),
                          ),
                        )
                        :1.width
                      ],
                    )),
              ))
        ],
      ),
    );
  }
}
