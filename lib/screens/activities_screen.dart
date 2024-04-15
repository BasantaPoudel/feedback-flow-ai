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

    return Scaffold(
        body: ListView(
      children: <Widget>[
        ListTile(
          title: const Text('Past In Class Activities'),
          subtitle: ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount:
                activities!.length, // replace with your actual list length
            itemBuilder: (BuildContext context, int index) {
              return Card(
                  color: const Color(0xFF6D7981),
                  child: ListTile(
                    title: Text(
                      activities[index].title,
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
                              RubricScreen(activity: activities[index]),
                        ),
                      );
                      // handle your item click here
                    },
                    // onTap: () {
                    //   Navigator.push(
                    //     context,
                    //     MaterialPageRoute(
                    //       builder: (context) => RubricScreen(
                    //         texts: activities[index]
                    //             .rubrics
                    //             .map((rubric) => rubric.name)
                    //             .toList(),
                    //       ),
                    //     ),
                    //   );
                    //   // handle your item click here
                    // },
                  ));

              // handle your item click here

              // handle your item click here
            },
          ),
        ),
        ListTile(
          title: const Text('Upcoming In Class Activities'),
          subtitle: ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount:
                activities.length, // replace with your actual list length
            itemBuilder: (BuildContext context, int index) {
              return Card(
                  color: const Color(0xFF6D7981),
                  child: ListTile(
                      title: Text(
                        activities[index].title,
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
                                RubricScreen(activity: activities[index]),
                          ),
                        );

                        // Navigator.push(
                        //   context,
                        //   MaterialPageRoute(
                        //     builder: (context) => RubricScreen(
                        //       texts: activities[index]
                        //           .rubrics
                        //           .map((rubric) => rubric.name)
                        //           .toList(),
                        //     ),
                        //   ),
                        // );
                        // handle your item click here
                      }));
            },
          ),
        ),
      ],
    ));
  }
}
