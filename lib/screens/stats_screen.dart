import 'package:fl_chart/fl_chart.dart';
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
              child: LineChart(LineChartData(
                  minX: 0,
                  maxX: 10,
                  minY: 0,
                  maxY: 10,
                  lineBarsData: [
                LineChartBarData(
                  spots: const [
                    FlSpot(1, 3.8),
                    FlSpot(3, 1.9),
                    FlSpot(6, 5),
                    FlSpot(8, 4.5),
                    FlSpot(10, 3.3),
                  ],
                )
              ]))),
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
