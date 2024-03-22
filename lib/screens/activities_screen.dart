import 'package:feedback_flow/models/activity.dart';
import 'package:feedback_flow/models/rubric.dart';
import 'package:feedback_flow/screens/score_screen.dart';
import 'package:flutter/material.dart';

class ActivitiesScreen extends StatelessWidget {
  List<Activity> activities = [
    Activity(
      title: 'Activity 1',
      rubrics: [Rubric(name: 'Rubric 1'), Rubric(name: 'Rubric 2')],
    ),
    Activity(
      title: 'Activity 2',
      rubrics: [Rubric(name: 'Rubric 3'), Rubric(name: 'Rubric 4')],
    ),
    // Add more activities as needed
  ];

  ActivitiesScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ListView(
      children: <Widget>[
        ListTile(
          title: const Text('Past In Class Activities'),
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
                          builder: (context) => const ScoreScreen(),
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
                            builder: (context) => const ScoreScreen(),
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
