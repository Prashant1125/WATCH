import 'package:flutter/material.dart';
import 'package:timer/view/clock.dart';
import 'package:timer/view/splash.dart';
import 'package:timer/view/timer.dart';

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
      home: Splash(),
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

  @override
  void initstate() {
    tb = TabController(length: 2, vsync: this);
    super.initState();
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
            Timer1(),
            Clock(),
          ],
          controller: tb,
        ),
      ),
    );
  }
}
