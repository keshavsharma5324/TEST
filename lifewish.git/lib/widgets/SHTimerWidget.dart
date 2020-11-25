import 'dart:async';
import 'package:flutter/material.dart';

class SHTimerWidget extends StatefulWidget {
  final startTime;
  final VoidCallback onTimerEnd;

  SHTimerWidget({this.onTimerEnd, this.startTime = 90, Key key})
      : super(key: key);

  @override
  SHTimerWidgetState createState() => SHTimerWidgetState();
}

class SHTimerWidgetState extends State<SHTimerWidget> {
  Timer _timer;
  int _start = 90;
  bool isPaused = false;

  @override
  void initState() {
    super.initState();
    _start = widget.startTime;
    startTimer();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text(
        "$_start",
        style: TextStyle(fontSize: 32, color: Colors.red, letterSpacing: 5),
      ),
    );
  }

  void stopTimer() {
    _timer.cancel();
  }

  void pauseTimer() {
    isPaused = true;
    _timer.cancel();
  }

  void resumeTimer() {
    startTimer();
  }

  void startTimer() {
    const oneSec = const Duration(seconds: 1);
    _timer = new Timer.periodic(
      oneSec,
      (Timer timer) => setState(
        () {
          if (_start < 1) {
            timer.cancel();
            widget.onTimerEnd();
          } else {
            _start = _start - 1;
          }
        },
      ),
    );
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }
}
