import 'package:feedback_flow/models/rubric.dart';

class Activity {
  String title;
  bool? isCompleted = false;
  bool? isDistributed = false;
  bool? isStarted = false;
  List<Rubric> rubrics;
  // Add other properties as needed

  Activity({required this.title, required this.rubrics});

  factory Activity.fromJson(Map<String, dynamic> json) {
    return Activity(
      title: json['title'],
      rubrics: json['rubrics'],
    );
  }

  factory Activity.fromMap(Map<String, dynamic> map) {
    return Activity(
      title: map['title'],
      rubrics: map['rubrics'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'rubrics': rubrics.map((rubric) => rubric.toMap()).toList(),
    };
  }
}

// Usage

