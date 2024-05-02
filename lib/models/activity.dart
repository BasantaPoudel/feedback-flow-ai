import 'package:feedback_flow/models/rubric.dart';

class Activity {
  String title;
  bool isCompleted;
  bool isDistributed;
  bool isStarted;
  Map<String, List<Rubric>> rubrics;
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
    Map<String, List<Rubric>> rubricsM = {};

    var rubrics = map['rubrics'];

    rubrics.forEach((key, value) {
      List<Rubric> rubricList = [];
      for (var value in value) {
        rubricList.add(Rubric.fromJson(value));
      }
      rubricsM[key] = rubricList;
      print(value);
    });

    return Activity(
      title: map['title'] as String,
      rubrics: rubricsM,
      isStarted: map['isStarted'] as bool,
      isCompleted: map['isCompleted'] as bool,
      isDistributed: map['isDistributed'] as bool,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'isCompleted': isCompleted,
      'isDistributed': isDistributed,
      'isStarted': isStarted,
      'rubrics': rubrics.map(
          (key, value) => MapEntry(key, value.map((e) => e.toMap()).toList())),
    };
  }

  factory Activity.fromSnapshot(doc) {
    return Activity.fromMap(doc.data()!);
  }
}

// Usage

