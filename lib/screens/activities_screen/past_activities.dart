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
          color: Color.fromRGBO(4, 149, 211, 1),
          borderRadius: BorderRadius.all(Radius.circular(10.0)),
        ),
        child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text("Past Activities",
                  style: TextStyle(
                    fontSize: 40,
                    foreground: Paint()
                      ..style = PaintingStyle.stroke
                      ..strokeWidth = 2
                      ..color = Colors.black!,
                  )),
              Container(
                  // padding: const EdgeInsets.all(10),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                    const Icon(
                      Icons.check_circle_outline,
                      size: 40,
                      color: Colors.black,
                    ),
                    Container(
                      // height: MediaQuery.of(context).size.height * 0.2,
                      width: MediaQuery.of(context).size.width * 0.8,
                      // padding: const EdgeInsets.all(10),
                      child: ListTile(
                        subtitle:
                            ListBuilder(activitiesList: widget.activitiesList),
                      ),
                    )
                  ]))
            ]));
  }
  // Add your widget code here
}
