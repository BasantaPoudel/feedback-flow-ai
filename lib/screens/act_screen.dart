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

class ActivitiesScreen extends StatefulWidget {
  const ActivitiesScreen({Key? key}) : super(key: key);

  @override
  State<ActivitiesScreen> createState() => _ActivitiesScreenState();
}

class _ActivitiesScreenState extends State<ActivitiesScreen> {
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
              const Text(
                'Hello, ',
              ),
              Text(
                userrepo.user?.displayName ?? 'User',
              )
            ],
          ),
        ),
        body: Column(
          children: [
            PastActivities(activitiesList: activitiesList ?? []),
            UpcomingActivities(activitiesList: activitiesList ?? []),
            BlocBuilder<HomeScreenCubit, HomeScreenState>(
                builder: (context, userState) {
              if (userState is ProfessorLoggedInState) {
                return Container(
                    padding: const EdgeInsets.all(8),
                    width: double.infinity,
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor:
                              const Color.fromRGBO(174, 206, 209, 1),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(6.0),
                          ),
                        ),
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const AddActivity(),
                              ));
                        },
                        child: const Text(
                          'Add Activity',
                          style: TextStyle(color: Colors.black),
                        )));
              }
              return Container();
            }),
          ],
        ),
      );
    }));
  }
}
