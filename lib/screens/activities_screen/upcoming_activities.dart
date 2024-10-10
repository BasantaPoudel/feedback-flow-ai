import 'package:feedback_flow/cubits/act_screen/act_screen_cubit.dart';
import 'package:feedback_flow/cubits/act_screen/act_screen_state.dart';
import 'package:feedback_flow/models/activity.dart';
import 'package:feedback_flow/screens/activities_screen/list_builder_upcoming.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

class UpcomingActivities extends StatefulWidget {
  const UpcomingActivities({Key? key, required this.activitiesList})
      : super(key: key);
  @override
  State<UpcomingActivities> createState() => _UpcomingActivitiesState();
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
              color: Color.fromRGBO(217, 217, 217, 1),
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
                Text('Upcoming Activities',
                    style: Theme.of(context).textTheme.headlineSmall),
                Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      SvgPicture.asset('assets/image/upcoming_activities.svg'),
                      Container(
                          constraints: BoxConstraints(
                              maxHeight:
                                  MediaQuery.of(context).size.height * 0.24),
                          width: MediaQuery.of(context).size.width * 0.7,
                          child: ListBuilderUpcoming(
                              activitiesList: widget.activitiesList))
                    ])
              ],
            )));
  }
}
