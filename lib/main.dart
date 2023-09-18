import 'dart:async';
import 'package:flutter_launcher_icons/xml_templates.dart';
import 'package:numberpicker/numberpicker.dart';
import 'package:flutter/material.dart';
import 'package:analog_clock/analog_clock.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Timer",
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  TabController? tb;
  int hour = 0;
  int min = 0;
  int sec = 0;
  String timetodisplay = "";
  bool started = true;
  bool stopped = true;
  int? timefortimer;
  bool cenceltimer = false;
  final dur = Duration(seconds: 1);

  @override
  void initstate() {
    tb = TabController(length: 2, vsync: this);
    super.initState();
  }

  void start() {
    setState(() {
      started = false;
      stopped = false;
    });

    timefortimer = ((hour * 3600) + (min * 60) + sec);
    Timer.periodic(dur, (Timer t) {
      setState(() {
        if (timefortimer! < 1 || cenceltimer == true) {
          t.cancel();
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => HomePage(),
            ),
          );
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
    setState(() {
      started = true;
      stopped = true;
      cenceltimer = true;
      timetodisplay = "";
    });
  }

  Widget timer() {
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

  Widget clock() {
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

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          backgroundColor: Colors.black,
          title: Text(
            "WATCH",
            style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.w800,
                fontFamily: "Oswald"),
          ),
          centerTitle: true,
          bottom: TabBar(
            tabs: <Widget>[
              Text(
                "Timer",
                style: TextStyle(
                  color: Colors.orange,
                ),
              ),
              Text(
                "Clock",
                style: TextStyle(
                  color: Colors.orange,
                ),
              ),
            ],
            labelStyle: TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.w600,
            ),
            labelPadding: EdgeInsets.only(
              bottom: 10.0,
            ),
            unselectedLabelColor: Colors.black54,
            controller: tb,
          ),
        ),
        body: TabBarView(
          children: <Widget>[
            timer(),
            clock(),
          ],
          controller: tb,
        ),
      ),
    );
  }
}
