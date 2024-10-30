import 'package:feedback_flow/models/rubric.dart';

class Activity {
  String? id;
  String title;
  bool isCompleted;
  bool isDistributed;
  bool isStarted;
  Map<String, List<Rubric>> rubrics;
  bool isFeedbackByProfessor;
  Map<String, dynamic> openFeedback;
  Map<String, dynamic> openFeedForward;
  // Add other properties as needed

  Activity(
      {required this.title,
      required this.rubrics,
      required this.isStarted,
      required this.isCompleted,
      required this.isDistributed,
      required this.isFeedbackByProfessor,
      this.openFeedback = const {},
      this.openFeedForward = const {},
      this.id});

  factory Activity.fromJson(Map<String, dynamic> json) {
    return Activity(
      id: json['id'],
      title: json['title'],
      rubrics: json['rubrics'],
      isStarted: json['isStarted'],
      isCompleted: json['isCompleted'],
      isDistributed: json['isDistributed'],
      isFeedbackByProfessor: json['isFeedbackByProfessor'],
      openFeedForward: json['openFeedForward'],
      openFeedback: json['openFeedback'],
    );
  }

  factory Activity.fromMap(Map<String, dynamic> map, id) {
    Map<String, List<Rubric>> rubricsM = {};

    var rubrics = map['rubrics'];

    rubrics.forEach((key, value) {
      List<Rubric> rubricList = [];
      for (var value in value) {
        rubricList.add(Rubric.fromJson(value));
      }
      rubricsM[key] = rubricList;
      // log.d(value);
    });

    Map<String, dynamic> openFeedbackFromMap = map['openFeedback'] ?? {};
    Map<String, dynamic> openFeedForwardFromMap = map['openFeedForward'] ?? {};

    return Activity(
      id: id as String,
      title: map['title'] as String,
      rubrics: rubricsM,
      isStarted: map['isStarted'] as bool,
      isCompleted: map['isCompleted'] as bool,
      isDistributed: map['isDistributed'] as bool,
      isFeedbackByProfessor: map['isFeedbackByProfessor'] as bool,
      openFeedback: openFeedbackFromMap,
      openFeedForward: openFeedForwardFromMap,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'isCompleted': isCompleted,
      'isDistributed': isDistributed,
      'isStarted': isStarted,
      'isFeedbackByProfessor': isFeedbackByProfessor,
      'openFeedback': openFeedback,
      'openFeedForward': openFeedForward,
      'rubrics': rubrics.map(
          (key, value) => MapEntry(key, value.map((e) => e.toMap()).toList())),
    };
  }

  factory Activity.fromSnapshot(doc) {
    return Activity.fromMap(doc.data()!, doc.id);
  }
}
