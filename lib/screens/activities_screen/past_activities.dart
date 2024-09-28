import 'package:feedback_flow/models/activity.dart';
import 'package:feedback_flow/screens/activities_screen/list_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class PastActivities extends StatefulWidget {
  @override
  State<PastActivities> createState() => _PastActivitiesState();
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
          color: Color.fromRGBO(228, 232, 235, 1),
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(25),
              topRight: Radius.circular(25),
              bottomLeft: Radius.circular(10),
              bottomRight: Radius.circular(10)),
        ),
        child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Text("Past Activities",
                  style: TextStyle(
                    fontSize: 25,
                    color: Colors.black,
                  )),
              Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Container(
                      constraints: BoxConstraints(
                          maxHeight: MediaQuery.of(context).size.height * 0.28),
                      width: MediaQuery.of(context).size.width * 0.7,
                      child: ListBuilder(activitiesList: widget.activitiesList),
                    ),
                    SvgPicture.asset('assets/image/past_activities.svg'),
                  ])
            ]));
  }
}
