import 'package:feedback_flow/cubits/act_screen/act_screen_cubit.dart';
import 'package:feedback_flow/cubits/act_screen/act_screen_state.dart';
import 'package:feedback_flow/models/activity.dart';
import 'package:feedback_flow/screens/activities_screen/list_builder_upcoming.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UpcomingActivities extends StatefulWidget {
  const UpcomingActivities({Key? key, required this.activitiesList})
      : super(key: key);
  @override
  _UpcomingActivitiesState createState() => _UpcomingActivitiesState();
  final List<Activity> activitiesList;
}

class _UpcomingActivitiesState extends State<UpcomingActivities> {
  @override
  Widget build(BuildContext context) {
    return BlocListener<ActScreenCubit, ActScreenState>(
        listener: (context, state) {
          if (state is ActivityErrorLoading) {
            ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Failed to load items')));
          }
        },
        child: Container(
            padding: const EdgeInsets.all(10),
            margin: const EdgeInsets.all(10),
            decoration: const BoxDecoration(
              color: Color.fromRGBO(255, 248, 238, 1),
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10),
                  topRight: Radius.circular(10),
                  bottomLeft: Radius.circular(25),
                  bottomRight: Radius.circular(25)),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Text('Upcoming Activities',
                    style: TextStyle(
                      fontSize: 25,
                      color: Colors.black,
                      // foreground: Paint()
                      //   ..shader = const LinearGradient(colors: <Color>[
                      //     Colors.white,
                      //     Colors.yellow,
                      //   ]).createShader(
                      //       const Rect.fromLTWH(0.0, 0.0, 200.0, 70.0)),
                    )),
                Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                  const Icon(
                    Icons.upcoming_outlined,
                    size: 40,
                    color: Colors.black,
                  ),
                  Container(
                      // height: MediaQuery.of(context).size.height * 0.2,
                      constraints: BoxConstraints(
                          maxHeight: MediaQuery.of(context).size.height * 0.28),
                      width: MediaQuery.of(context).size.width * 0.8,
                      child: ListBuilderUpcoming(
                          activitiesList: widget.activitiesList))
                ])
              ],
            )));
  }
}
