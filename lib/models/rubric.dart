class Rubric {
  String name;
  // Add other properties as needed
  int score = 0;
  Rubric({required this.name, required score});

  factory Rubric.fromJson(Map<String, dynamic> json) {
    return Rubric(
      name: json['name'],
      score: json['score'],
    );
  }

  factory Rubric.fromMap(Map<String, dynamic> map) {
    return Rubric(
      name: map['name'],
      score: map['score'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'score': score,
    };
  }
}
