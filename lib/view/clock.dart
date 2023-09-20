import 'package:analog_clock/analog_clock.dart';
import 'package:flutter/material.dart';

class Clock extends StatefulWidget {
  const Clock({super.key});

  @override
  State<Clock> createState() => _ClockState();
}

class _ClockState extends State<Clock> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Align(
        child: AnalogClock(
          decoration: BoxDecoration(
              border: Border.all(width: 3.0, color: Colors.black),
              color: Colors.black,
              shape: BoxShape.circle), // decoration
          width: 300.0,
          isLive: true,
          hourHandColor: Colors.white,
          minuteHandColor: Colors.white,
          showSecondHand: true,
          numberColor: Colors.white,
          showNumbers: true,
          textScaleFactor: 1.5,
          showTicks: true,
          showDigitalClock: true,
          digitalClockColor: Colors.white,
          datetime: DateTime.now(),
        ), // analog clock
      ),
    ); // center
  }
}
