import 'package:feedback_flow/models/activity.dart';

class UserModel {
  final String name;
  final String role;
  final String email;
  late bool? isPresenter;

  List<Activity>? activities;

  UserModel(
      {required this.name,
      required this.email,
      required this.role,
      this.isPresenter,
      this.activities});

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      name: json['name'],
      email: json['email'],
      role: json['role'],
      isPresenter: json['isPresenter'] ?? false,
      // activities: json['activities'] ?? [],
    );
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      name: map['name'],
      email: map['email'],
      role: map['role'],
      isPresenter: map['isPresenter'] ?? false,
      // activities: map['activities'] as List<Activity>,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'email': email,
      'role': role,
      'isPresenter': isPresenter,
      // 'activities': activities,
    };
  }

  factory UserModel.fromSnapshot(doc) {
    return UserModel.fromMap(doc.data()!);
  }

  setPresenter(bool isPresenter) {
    this.isPresenter = isPresenter;
  }

  setActivities(List<Activity> activities) {
    this.activities = activities;
  }
}
