import 'package:feedback_flow/cubits/activities_screen/activities_screen_cubit.dart';
import 'package:feedback_flow/cubits/activities_screen/activities_screen_state.dart';
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
    return BlocListener<ActivitiesScreenCubit, ActivitiesScreenState>(
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
              color: Color.fromRGBO(8, 238, 238, 1),
              borderRadius: BorderRadius.all(Radius.circular(10.0)),
            ),
            child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const Text("Upcoming Activities"),
                  Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                    const Icon(Icons.upcoming_outlined),
                    ListBuilderUpcoming(activitiesList: widget.activitiesList)
                  ]),
                ])));
  }
}
