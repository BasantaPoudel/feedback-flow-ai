import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:feedback_flow/cubits/activities_screen/activities_screen_cubit.dart';
import 'package:feedback_flow/models/activity.dart';
import 'package:feedback_flow/screens/rubric_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ActivitiesScreen extends StatelessWidget {
  ActivitiesScreen({super.key});
  @override
  Widget build(BuildContext context) {
    ActivitiesScreenCubit? activitiesScreenCubit =
        BlocProvider.of<ActivitiesScreenCubit>(context);
    List<Activity>? activities = activitiesScreenCubit.upcomingActivities;

    final Stream<QuerySnapshot> _activityStream =
        FirebaseFirestore.instance.collection('activities').snapshots();

    return StreamBuilder<QuerySnapshot>(
      stream: _activityStream,
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return const Text('Something went wrong');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Text("Loading");
        }

        return ListView(
          children: snapshot.data!.docs
              .map((DocumentSnapshot document) {
                Map<String, dynamic> data =
                    document.data()! as Map<String, dynamic>;
                Activity activity = Activity.fromMap(data);
                return Card(
                    color: const Color(0xFF6D7981),
                    child: ListTile(
                      title: Text(
                        activity.title,
                        style: const TextStyle(
                          color: Colors.white, // Change text color to white
                        ),
                      ),
                      onTap: () {
                        Navigator.push(
                          context,
                          //TODO - Correct the logic to display ScoreScreen or RubricScreen based on the activity status
                          MaterialPageRoute(
                            builder: (context) =>
                                RubricScreen(activity: activity),
                          ),
                        );
                      },
                    ));
              })
              .toList()
              .cast(),
        );
      },
    );
  }
}
