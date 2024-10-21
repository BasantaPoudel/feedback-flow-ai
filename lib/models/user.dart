import 'package:feedback_flow/models/activity.dart';

class UserModel {
  final String id = '';
  late String name;
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
      activities: json['activities'] ?? [],
    );
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    var activities = map['activities'] != null
        ? List<Activity>.from(map['activities']
            .map((x) => Activity.fromMap(x, ''))) // TODO - Fix the empty id
        : null;
    return UserModel(
      name: map['name'],
      email: map['email'],
      role: map['role'],
      isPresenter: map['isPresenter'] ?? false,
      activities: activities ?? [],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'email': email,
      'role': role,
      'isPresenter': isPresenter,
      'activities': activities?.map((activity) => activity.toMap()).toList(),
    };
  }

  setPresenter(bool isPresenter) {
    this.isPresenter = isPresenter;
  }

  addActivity(Activity activity) {
    List<Activity> temp = [activity];

    if (activities == null) {
      activities = temp;
    } else if (activities!
        .where((ac) => ac.title == activity.title)
        .isNotEmpty) {
      activities!.removeWhere((ac) => ac.title == activity.title);
      activities!.add(activity);
    } else {
      activities!.add(activity);
    }
  }

  setActivities(List<Activity> activities) {
    this.activities = activities;
  }

  setname(String name) {
    this.name = name;
  }
}
