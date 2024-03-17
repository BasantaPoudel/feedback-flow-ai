import 'package:feedback_flow/models/rubric.dart';

class Activity {
  String title;
  List<Rubric> rubrics;
  // Add other properties as needed

  Activity({required this.title, required this.rubrics});
}

// Usage
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
