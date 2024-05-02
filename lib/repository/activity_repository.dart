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

  updateActivity(Activity activity) async {
    try {
      // final currentUser = UserModel.fromSnapshot(user);
      final query = activitiesRef.where("title", isEqualTo: activity.title);
      var querySnapshot = await query.get();

      for (var snapshot in querySnapshot.docs) {
        var documentID = snapshot.id;
        activitiesRef
            .doc(documentID)
            .update(activity.toMap()); // <-- Document ID
      }
    } catch (e) {
      print('Error: $e');
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

  //     Map - Activity(
  //         title: "Activity 2",
  //        Array -  rubrics: {
  //                0 - "uid-1":
  //                          array 0 - map {Rubric(name: "World History", score: 88),
  // array 1 - map Rubric(name: "World History", score: 88)
  // },
  //       1 - "uid-2":
  //                 0 - {Rubric(name: "World History", score: 12),
  // Rubric(name: "World History", score: 82)
  // }
  //         },
  //         isStarted: false,
  //         isCompleted: false,
  //         isDistributed: false)
//    }
}
