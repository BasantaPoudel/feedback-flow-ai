import 'package:feedback_flow/models/activity.dart';
import 'package:feedback_flow/models/rubric.dart';
import 'package:feedback_flow/screens/rubric_screen.dart';
import 'package:flutter/material.dart';

class ActivitiesTeacherScreen extends StatelessWidget {
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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () {},
          child: const Icon(Icons.add),
        ),
        body: ListView(
          children: <Widget>[
            ListTile(
              title: Text('Past In Class Activities'),
              subtitle: ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount:
                    activities.length, // replace with your actual list length
                itemBuilder: (BuildContext context, int index) {
                  return ListTile(
                    title: Text(activities[index].title),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => RubricScreen(
                            texts: activities[index]
                                .rubrics
                                .map((rubric) => rubric.name)
                                .toList(),
                          ),
                        ),
                      );
                      // handle your item click here
                    },
                  );
                },
              ),
            ),
            ListTile(
              title: Text('Upcoming In Class Activities'),
              subtitle: ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: 5, // replace with your actual list length
                itemBuilder: (BuildContext context, int index) {
                  return ListTile(
                    title: Text('Current Item $index'),
                    onTap: () {
                      // handle your item click here
                    },
                  );
                },
              ),
            ),
          ],
        ));
  }
}
