import 'package:feedback_flow/models/activity.dart';
import 'package:feedback_flow/screens/activities_screen/list_builder.dart';
import 'package:flutter/material.dart';

class PastActivities extends StatefulWidget {
  @override
  _PastActivitiesState createState() => _PastActivitiesState();
  final List<Activity> activitiesList;
  const PastActivities({Key? key, required this.activitiesList})
      : super(key: key);
}

class _PastActivitiesState extends State<PastActivities> {
  List<Activity> activitiesList = [];

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.all(10),
        margin: const EdgeInsets.all(10),
        decoration: const BoxDecoration(
          color: Color.fromRGBO(167, 203, 209, 1),
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(25),
              topRight: Radius.circular(25),
              bottomLeft: Radius.circular(10),
              bottomRight: Radius.circular(10)),
          // borderRadius: BorderRadius.all(Radius.circular(10.0)),
        ),
        child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text("Past Activities",
                  style: TextStyle(
                    fontSize: 25,
                    color: Colors.white,
                    // foreground: Paint()
                    //   ..shader = const LinearGradient(colors: <Color>[
                    //     Colors.white,
                    //     Colors.yellow,
                    //   ]).createShader(
                    //       const Rect.fromLTWH(0.0, 0.0, 200.0, 70.0)),
                  )),
              Container(
                  // padding: const EdgeInsets.all(10),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                    Icon(
                      Icons.check_circle_outline,
                      size: 40,
                      color: Colors.green.shade800,
                    ),
                    Container(
                      // height: MediaQuery.of(context).size.height * 0.2,
                      constraints: BoxConstraints(
                          maxHeight: MediaQuery.of(context).size.height * 0.3),
                      width: MediaQuery.of(context).size.width * 0.8,
                      // padding: const EdgeInsets.all(10),
                      child: ListBuilder(activitiesList: widget.activitiesList),
                    )
                  ]))
            ]));
  }
  // Add your widget code here
}
