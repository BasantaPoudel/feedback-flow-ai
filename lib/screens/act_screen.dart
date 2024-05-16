import 'package:feedback_flow/cubits/act_screen/act_screen_cubit.dart';
import 'package:feedback_flow/cubits/act_screen/act_screen_state.dart';
import 'package:feedback_flow/cubits/home_screen/home_screen_cubit.dart';
import 'package:feedback_flow/cubits/home_screen/home_screen_state.dart';
import 'package:feedback_flow/models/activity.dart';
import 'package:feedback_flow/repository/user_repository.dart';
import 'package:feedback_flow/screens/activities_screen/add_activity.dart';
import 'package:feedback_flow/screens/activities_screen/past_activities.dart';
import 'package:feedback_flow/screens/activities_screen/upcoming_activities.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ActScreen extends StatefulWidget {
  const ActScreen({Key? key}) : super(key: key);

  @override
  _ActScreenState createState() => _ActScreenState();
}

class _ActScreenState extends State<ActScreen> {
  @override
  Widget build(BuildContext context) {
    final UserRepository userrepo = UserRepository();
    return BlocListener<ActScreenCubit, ActScreenState>(
        listener: (context, state) {
      if (state is ActivityErrorLoading) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Failed to load items')),
        );
      }
    }, child: BlocBuilder<ActScreenCubit, ActScreenState>(
            builder: (context, stateActivity) {
      List<Activity>? activitiesList = stateActivity.getAllActivities;

      return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blue,
          title: const Text(
            'Activities',
            style: TextStyle(color: Colors.white),
          ),
        ),
        backgroundColor: Colors.blue,
        body: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Colors.grey.shade300, Colors.white],
            ),
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30), topRight: Radius.circular(30)),
          ),
          child: Column(
            children: [
              PastActivities(activitiesList: activitiesList ?? []),
              UpcomingActivities(activitiesList: activitiesList ?? []),
              BlocBuilder<HomeScreenCubit, HomeScreenState>(
                  builder: (context, userState) {
                if (userState is TeacherLoggedInState) {
                  return Container(
                      width: double.infinity,
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color.fromARGB(255, 88, 158, 90),
                          ),
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => AddActivity(),
                                ));
                          },
                          child: Text(
                            'Add Activity',
                            style: TextStyle(color: Colors.white),
                          )));
                }
                return Container();
              }),
            ],
          ),
        ),
      );
    }));
  }
}
