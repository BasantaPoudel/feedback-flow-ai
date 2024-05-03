import 'package:flutter/material.dart';

class Stats extends StatefulWidget {
  @override
  _StatsState createState() => _StatsState();
}

class _StatsState extends State<Stats> {
  @override
  Widget build(BuildContext context) {
    return Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
      Expanded(
          child: Column(
        children: [
          Expanded(
              child: Container(
                  color: Colors.blue,
                  child: Center(
                    child: Text('R22222'),
                  ))),
          Expanded(
              child: Container(
                  color: Colors.green,
                  child: Center(
                    child: Text('R3'),
                  ))),
          Expanded(
              child: Container(
                  color: Colors.yellow,
                  child: Center(
                    child: Text('R4'),
                  ))),
        ],
      )),
      Expanded(
          child: Container(
        color: Colors.blue,
        child: Center(
          child: Text('R12'),
        ),
      ))
    ]);
  }
}
