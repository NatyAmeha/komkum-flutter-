import 'dart:async';

import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:komkum/view/widget/custom_text.dart';

import 'package:slide_countdown/slide_countdown.dart';


class TimerCounter extends StatefulWidget {
  int timeInSecond;
  Function onFinished;
  Function(Duration)? onchange;
  SeparatorType separatorType;
  String timeUpMessage;
  double padding;
  Color color;
  double fontSize;
  TimerCounter(
      {required this.timeInSecond,
      required this.onFinished,
      this.separatorType = SeparatorType.title,
      this.timeUpMessage = "Expired",
      this.padding = 8,
      this.onchange,
      this.fontSize = 10,
      this.color = Colors.red});

  @override
  State<TimerCounter> createState() => _TimerCounterState();
}

class _TimerCounterState extends State<TimerCounter> {
  Timer? countDownTimer;
  @override
  Widget build(BuildContext context) {
    return SlideCountdown(
      duration: Duration(seconds: widget.timeInSecond),
      // showZeroValue: false,

      padding: EdgeInsets.all(widget.padding),
      separatorPadding: const EdgeInsets.all(8),
      textStyle: TextStyle(
          fontSize: widget.fontSize,
          fontWeight: FontWeight.bold,
          color: Colors.white),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8), color: widget.color),
      separatorType: widget.separatorType,
      durationTitle: const DurationTitle(
        days: "D:",
        hours: "H:",
        minutes: "M:",
        seconds: "S",
      ),
      onDone: () {
        widget.onFinished();
      },
      onChanged: (value) {
        widget.onchange?.call(value);
      },
      replacement: widget.timeUpMessage.isNotEmpty
          ? Badge(
              badgeContent: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                child: CustomText(
                  widget.timeUpMessage,
                  textStyle: Theme.of(context).textTheme.bodyMedium,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              animationType: BadgeAnimationType.scale,
              animationDuration: Duration.zero,
              shape: BadgeShape.square,
              padding: const EdgeInsets.all(8),
              borderRadius: BorderRadius.circular(8),
            )
          : const SizedBox(),
    );
  }
}
