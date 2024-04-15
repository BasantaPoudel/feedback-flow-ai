import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:feedback_flow/models/activity.dart';
import 'package:feedback_flow/repository/main_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ActivityRepository extends MainRepository {
  @override
  User? user = FirebaseAuth.instance.currentUser;

  void addActivity(activity) {
    try {
      activitiesRef.add(activity.toMap());
    } catch (e) {
      print(e);
    }
  }

  Future<List<Activity>> getActivities() async {
    List<Activity> activities = [];

    try {
      await FirebaseFirestore.instance
          .collection('activities')
          .get()
          .then((value) {
        for (var doc in value.docs) {
          activities.add(Activity.fromMap(doc.data()));
        }
        return activities;
      });
    } catch (e) {
      print(e);
    }
    return activities;
  }

  // void addActivities() {
  //   List<Activity> activities = [
  //     Activity(
  //       title: 'New Activity 1',
  //       rubrics: [
  //         Rubric(name: 'New Rubric 1', score: 1),
  //         Rubric(name: 'New Rubric 2', score: 1),
  //       ],
  //     ),
  //     Activity(
  //       title: 'New Activity 2',
  //       rubrics: [
  //         Rubric(name: 'New Rubric 3', score: 1),
  //         Rubric(name: 'New Rubric 4', score: 1),
  //       ],
  //     ),
  //     // Add more activities as needed
  //   ];

  //   for (var element in activities) {
  //     addActivity(element);
  //   }
  // }
}
