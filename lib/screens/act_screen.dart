import 'package:feedback_flow/cubits/act_screen/act_screen_cubit.dart';
import 'package:feedback_flow/cubits/act_screen/act_screen_state.dart';
import 'package:feedback_flow/cubits/home_screen/home_screen_cubit.dart';
import 'package:feedback_flow/cubits/home_screen/home_screen_state.dart';
import 'package:feedback_flow/models/activity.dart';
import 'package:feedback_flow/repository/user_repository.dart';
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
          title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Hi, '),
                Text(userrepo.user?.displayName ?? 'User')
              ]),
        ),
        body: Container(
          // color: Color.fromRGBO(133, 196, 223, 1),
          child: Column(
            children: [
              PastActivities(activitiesList: activitiesList ?? []),
              UpcomingActivities(activitiesList: activitiesList ?? [])
            ],
          ),
        ),
        floatingActionButton: BlocBuilder<HomeScreenCubit, HomeScreenState>(
            builder: (context, userState) {
          if (userState is TeacherLoggedInState) {
            return FloatingActionButton(
              onPressed: () {
                Navigator.pushNamed(context, '/add_activity');
              },
              child: const Icon(Icons.add),
            );
          }
          return Container();
        }),
      );
    }));
  }
}
