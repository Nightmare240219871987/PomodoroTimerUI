import 'dart:async';

import 'package:flutter/material.dart';

// ignore: must_be_immutable
class PomodoroWidget extends StatefulWidget {
  double time;
  String title;
  void Function() onFinished;
  void Function()? onCancel;
  void Function(int elapsedTime)? onTick;

  PomodoroWidget({
    super.key,
    required this.time,
    required this.onFinished,
    this.onCancel,
    this.onTick,
    required this.title,
  });

  @override
  State<PomodoroWidget> createState() => _PomodoroWidgetState();
}

class _PomodoroWidgetState extends State<PomodoroWidget> {
  final int _periodic = 80;
  Timer? _timer;
  late int _maxElapsedTime;
  int _currentElapsedTime = 0;
  double _runningTime = 0;
  late DateTime _startTime;
  bool _isRunning = false;

  void _startTimer() {
    _isRunning = true;
    _maxElapsedTime = widget.time.toInt() * 60000;
    _startTime = DateTime.now();
    _timer ??= _timer = Timer.periodic(Duration(milliseconds: _periodic), _run);
  }

  void _run(Timer t) {
    DateTime endTime = DateTime.now();
    _currentElapsedTime = endTime.difference(_startTime).inMilliseconds;

    if (_currentElapsedTime >= _maxElapsedTime) {
      _stopTimer();
      _runningTime = widget.time;
      widget.onFinished();
    } else {
      if (widget.onTick != null) {
        widget.onTick!(_currentElapsedTime);
      }
      setState(() {
        _runningTime = ((_maxElapsedTime - _currentElapsedTime) / 60000);
      });
    }
  }

  void _stopTimer() {
    if (_timer != null) {
      _timer!.cancel();
      setState(() {
        _isRunning = false;
        _runningTime = widget.time;
      });
      if (widget.onCancel != null) {
        widget.onCancel!();
      }
      _timer = null;
    }
  }

  int _getMinFromDouble(double value) {
    return value.floor();
  }

  int _getSecFromDouble(double value) {
    return ((value - value.floor()) * 60).toInt();
  }

  @override
  void initState() {
    _runningTime = widget.time;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 6.0,
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(width: double.infinity),
        Text(
          "Aufgabe",
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w300),
          textAlign: TextAlign.center,
        ),
        SizedBox(width: double.infinity),
        Text(
          widget.title,
          style: TextStyle(fontSize: 18),
          textAlign: TextAlign.center,
        ),
        Text(
          "${_getMinFromDouble(_runningTime)} Min ${_getSecFromDouble(_runningTime)} Sek",
          style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
          textAlign: TextAlign.center,
        ),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton.filled(
              constraints: BoxConstraints(minWidth: 65, minHeight: 65),
              onPressed: () {
                if (!_isRunning && _runningTime > 0) {
                  _startTimer();
                } else {
                  _stopTimer();
                }
              },
              icon: Icon(_isRunning ? Icons.stop : Icons.play_arrow),
            ),
          ],
        ),
      ],
    );
  }
}
