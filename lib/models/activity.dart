import 'package:feedback_flow/models/rubric.dart';

class Activity {
  String title;
  bool isCompleted;
  bool isDistributed;
  bool isStarted;
  List<Rubric> rubrics;
  // Add other properties as needed

  Activity(
      {required this.title,
      required this.rubrics,
      required this.isStarted,
      required this.isCompleted,
      required this.isDistributed});

  factory Activity.fromJson(Map<String, dynamic> json) {
    return Activity(
      title: json['title'],
      rubrics: json['rubrics'],
      isStarted: json['isStarted'],
      isCompleted: json['isCompleted'],
      isDistributed: json['isDistributed'],
    );
  }

  factory Activity.fromMap(Map<String, dynamic> map) {
    return Activity(
      title: map['title'],
      rubrics: List<Rubric>.from(
          map['rubrics'].map((rubric) => Rubric.fromMap(rubric))),
      isStarted: map['isStarted'],
      isCompleted: map['isCompleted'],
      isDistributed: map['isDistributed'],
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

