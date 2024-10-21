import 'package:cloud_firestore/cloud_firestore.dart';

class Rubric {
  // Add other properties as needed
  //TODO - For now added default values to avoid null error
  String? id = '';
  String title;
  String? description;
  double score;

  Rubric({required this.title, this.score = 0, this.id, this.description});

  factory Rubric.fromJson(Map<String, dynamic> json) {
    return Rubric(
      title: json['title'],
      description: json['description'],
      score: json['score'].toDouble(),
    );
  }

  factory Rubric.fromMap(Map<String, dynamic> map) {
    return Rubric(
      title: map['title'],
      description: map['description'],
      score: map['score'].toDouble(),
    );
  }

  factory Rubric.fromDocument(DocumentSnapshot doc) {
    return Rubric(
      id: doc.id,
      title: doc['title'],
      description: doc['description'],
    );
  }
  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'description': description,
      'score': score,
    };
  }
}
