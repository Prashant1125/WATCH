import 'dart:async';

import 'package:flutter/material.dart';
import 'package:numberpicker/numberpicker.dart';
import 'package:timer/main.dart';

class Timer1 extends StatefulWidget {
  const Timer1({super.key});

  @override
  State<Timer1> createState() => _Timer1State();
}

class _Timer1State extends State<Timer1> {
  int hour = 0;
  int min = 0;
  int sec = 0;
  String timetodisplay = "";
  bool started = true;
  bool stopped = true;
  int? timefortimer;
  bool cenceltimer = false;
  final dur = Duration(seconds: 1);
  Timer? timer;

  void start() {
    setState(() {
      started = false;
      stopped = false;
    });

    timefortimer = ((hour * 3600) + (min * 60) + sec);
    timer = Timer.periodic(dur, (Timer t) {
      timer = t;
      setState(() {
        if (timefortimer! < 1 || cenceltimer == true) {
          t.cancel();
          // Navigator.pushReplacement(
          //   context,
          //   MaterialPageRoute(
          //     builder: (context) => HomePage(),
          //   ),
          // );
        } else if (timefortimer! < 60) {
          timetodisplay = timefortimer.toString();
          timefortimer = timefortimer! - 1;
        } else if (timefortimer! < 3600) {
          int h = timefortimer! ~/ 3600;
          int m = timefortimer! ~/ 60;
          int s = timefortimer! - (60 * m);
          timetodisplay = m.toString() + ":" + s.toString();
          timefortimer = timefortimer! - 1;
        } else {
          int h = timefortimer! ~/ 3600;
          int t = timefortimer! - (3600 * h);
          int m = t ~/ 60;
          int s = t - (60 * m);

          timetodisplay =
              h.toString() + ":" + m.toString() + ":" + s.toString();
          timefortimer = timefortimer! - 1;
        }
      });
    });
  }

  void stop() {
    timer!.cancel();
    setState(() {
      started = true;
      stopped = true;
      cenceltimer = false;
      timetodisplay = "";
      hour = 0;
      min = 0;
      sec = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Expanded(
              flex: 6,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.only(
                          bottom: 10.0,
                        ),
                        child: Text(
                          "HH",
                          style: TextStyle(
                            fontSize: 20.0,
                            color: Colors.black,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                      ),
                      NumberPicker(
                          minValue: 0,
                          maxValue: 23,
                          value: hour,
                          itemWidth: 75,
                          onChanged: ((val) {
                            setState(() {
                              hour = val;
                            });
                          })),
                    ],
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.only(
                          bottom: 10.0,
                        ),
                        child: Text(
                          "MM",
                          style: TextStyle(
                            fontSize: 20.0,
                            color: Colors.black,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                      ),
                      NumberPicker(
                          minValue: 0,
                          maxValue: 59,
                          value: min,
                          itemWidth: 75,
                          onChanged: ((val) {
                            setState(() {
                              min = val;
                            });
                          })),
                    ],
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.only(
                          bottom: 10.0,
                        ),
                        child: Text(
                          "SS",
                          style: TextStyle(
                            fontSize: 20.0,
                            color: Colors.black,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                      ),
                      NumberPicker(
                          minValue: 0,
                          maxValue: 59,
                          value: sec,
                          itemWidth: 75,
                          onChanged: ((val) {
                            setState(() {
                              sec = val;
                            });
                          })),
                    ],
                  ),
                ],
              )),
          Expanded(
            flex: 0,
            child: Text(
              timetodisplay,
              style: TextStyle(
                  fontSize: 50.0,
                  fontWeight: FontWeight.w400,
                  color: Colors.green),
            ),
          ),
          Expanded(
            flex: 3,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                ElevatedButton(
                  onPressed: started ? start : null,
                  child: Text(
                    "START",
                    style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.w700,
                      color: Colors.green,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    padding:
                        EdgeInsets.symmetric(vertical: 12.0, horizontal: 30.0),
                  ),
                ),
                ElevatedButton(
                  onPressed: stopped ? null : stop,
                  child: Text(
                    "STOP",
                    style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.w700,
                      color: Colors.green,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    padding:
                        EdgeInsets.symmetric(vertical: 12.0, horizontal: 30.0),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
