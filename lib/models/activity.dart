import 'package:feedback_flow/models/rubric.dart';

class Activity {
  String title;
  bool? isCompleted = false;
  bool? isDistributed = false;
  bool isStarted;
  List<Rubric> rubrics;
  // Add other properties as needed

  Activity(
      {required this.title, required this.rubrics, required this.isStarted});

  factory Activity.fromJson(Map<String, dynamic> json) {
    return Activity(
      title: json['title'],
      rubrics: json['rubrics'],
      isStarted: json['isStarted'],
    );
  }

  factory Activity.fromMap(Map<String, dynamic> map) {
    return Activity(
      title: map['title'],
      rubrics: List<Rubric>.from(
          map['rubrics'].map((rubric) => Rubric.fromMap(rubric))),
      isStarted: map['isStarted'],
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

