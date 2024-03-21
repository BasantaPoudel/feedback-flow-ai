import 'package:feedback_flow/models/rubric.dart';

class Activity {
  String title;
  bool? isCompleted = false;
  bool? isDistributed = false;
  bool? isStarted = false;
  List<Rubric> rubrics;
  // Add other properties as needed

  Activity({required this.title, required this.rubrics});
}

// Usage

