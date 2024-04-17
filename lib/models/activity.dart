import 'package:cloud_firestore/cloud_firestore.dart';
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
      rubrics: List<Rubric>.from(
          map['rubrics'].map((rubric) => Rubric.fromMap(rubric))),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'isCompleted': isCompleted,
      'isDistributed': isDistributed,
      'isStarted': isStarted,
      'rubrics': rubrics.map((rubric) => rubric.toMap()).toList(),
    };
  }

  factory Activity.fromSnapshot(doc) {
    return Activity.fromMap(doc.data()!);
  }
}

// Usage

