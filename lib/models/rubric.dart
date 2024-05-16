class Rubric {
  String title;
  // Add other properties as needed
  double score;

  Rubric({required this.title, required this.score});

  factory Rubric.fromJson(Map<String, dynamic> json) {
    return Rubric(
      title: json['name'],
      score: json['score'].toDouble(),
    );
  }

  factory Rubric.fromMap(Map<String, dynamic> map) {
    return Rubric(
      title: map['name'],
      score: map['score'].toDouble(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': title,
      'score': score,
    };
  }
}
