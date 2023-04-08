import 'package:flutter/material.dart';

// ignore: must_be_immutable
class TimeCounter extends StatefulWidget {
  int seconds;
  final VoidCallback? onComplete;
  TimeCounter({this.seconds = 60, this.onComplete, Key? key}) : super(key: key);

  @override
  State<TimeCounter> createState() => _TimeCounterState();
}

class _TimeCounterState extends State<TimeCounter> {
  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    scheduleTimeout();
    return Text('${widget.seconds}s');
  }

  scheduleTimeout() {
    Future.delayed(
        const Duration(
          seconds: 1,
        ), () {
      if (widget.seconds == 0) {
        widget.onComplete!();
      } else {
        if (mounted) {
          setState(() {
            widget.seconds -= 1;
          });
        }
      }
    });
  }
}
