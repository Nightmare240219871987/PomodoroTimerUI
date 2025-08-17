import 'dart:async';

import 'package:flutter/material.dart';

// ignore: must_be_immutable
class PomodoroTimerWidget extends StatefulWidget {
  double time; // Zeit die erreicht werden soll.
  String title;
  void Function() onFinished; // Callback für den Fall das fertig ist
  void Function() onCancel; // Callback für den Fall das abgebrochen wird.

  PomodoroTimerWidget({
    super.key,
    required this.time,
    required this.title,
    required this.onFinished,
    required this.onCancel,
  });

  @override
  State<PomodoroTimerWidget> createState() => _PomodoroTimerWidgetState();
}

class _PomodoroTimerWidgetState extends State<PomodoroTimerWidget> {
  Timer? _timer;
  int iterationTime = 100;
  int elapsedMillisec = 0; // Abgelaufene Sekunde seit dem Start des Timer.

  void _startTimer() {
    setState(() {
      elapsedMillisec = 0;
    });
    if (_timer != null) {
      _timer!.cancel();
    }
    _timer = Timer.periodic(Duration(milliseconds: iterationTime), _run);
  }

  void _run(Timer t) {
    setState(() {
      elapsedMillisec += iterationTime;
    });
    // Überprüft ob elapsedMillisec größer als die gesamt Zeit in Ms ist
    if (elapsedMillisec > widget.time * 60000) {
      _stopTimer();
      widget.onFinished();
    }
  }

  void _stopTimer() {
    setState(() {
      elapsedMillisec = 0;
    });
    if (_timer != null && _timer!.isActive) {
      _timer!.cancel();
      widget.onCancel();
    }
  }

  int _doubleToMin(double timeDecimal) {
    return timeDecimal.floor();
  }

  int _doubleToSec(double timeDecimal) {
    return ((timeDecimal - timeDecimal.floor()) * 60).toInt();
  }

  @override
  Widget build(BuildContext context) {
    int maxMillisec = widget.time.toInt() * 60000;
    double remainingMillisec =
        (maxMillisec - elapsedMillisec) / 60000.toDouble();
    return Card(
      color: Theme.of(context).primaryColor,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          spacing: 16.0,
          children: [
            Text(
              "Aufgabe",
              style: TextStyle(
                color: Theme.of(context).secondaryHeaderColor,
                fontSize: 18,
                fontWeight: FontWeight.w200,
              ),
            ),
            Text(
              widget.title,
              style: TextStyle(
                color: Theme.of(context).secondaryHeaderColor,
                fontSize: 18,
                fontWeight: FontWeight.w400,
              ),
              textAlign: TextAlign.center,
            ),
            Text(
              "${_doubleToMin(remainingMillisec)} Min ${_doubleToSec(remainingMillisec)} Sek",
              style: TextStyle(
                color: Theme.of(context).secondaryHeaderColor,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: WidgetStatePropertyAll(
                      Theme.of(context).primaryColorDark,
                    ),
                    foregroundColor: WidgetStatePropertyAll(
                      Theme.of(context).secondaryHeaderColor,
                    ),
                  ),
                  onPressed: _startTimer,
                  child: Text("Start"),
                ),
                OutlinedButton(
                  style: ButtonStyle(
                    backgroundColor: WidgetStatePropertyAll(
                      Theme.of(context).primaryColorDark,
                    ),
                    foregroundColor: WidgetStatePropertyAll(
                      Theme.of(context).secondaryHeaderColor,
                    ),
                  ),
                  onPressed: _stopTimer,
                  child: Text("Stop"),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
