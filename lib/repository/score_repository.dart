import 'package:feedback_flow/models/activity.dart';
import 'package:feedback_flow/repository/main_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ScoreRepository extends MainRepository {
  @override
  User? user = FirebaseAuth.instance.currentUser;

  void sendScoreToFirebase(presenter) async {
    try {
      roleBasedUsersRef
          .where("email", isEqualTo: presenter!.email)
          .get()
          .then((value) {
        if (value.docs.isNotEmpty) {
          List<dynamic>? activities = presenter.activities
              ?.map((activity) => activity.toMap())
              .toList();
          roleBasedUsersRef.doc(value.docs.first.id).update({
            'activities': activities,
          });
        }
      });
    } catch (e) {
      print(e.toString());
    }
  }

  void addScoreByProvider(presenter) async {
    try {
      roleBasedUsersRef
          .where("email", isEqualTo: presenter!.email)
          .get()
          .then((value) {
        if (value.docs.isNotEmpty) {
          List<dynamic> activities = presenter.activities
              ?.map((activity) => activity.toMap())
              .toList();
          roleBasedUsersRef.doc(value.docs.first.id).update({
            'activities': activities,
          });
        }
      });
    } catch (e) {
      print(e.toString());
    }
  }

  Future<List<Activity>> getActivities() async {
    List<Activity> activities = [];
    try {
      await roleBasedUsersRef
          .where("email", isEqualTo: user!.email)
          .get()
          .then((value) {
        if (value.docs.isNotEmpty) {
          activities = value.docs.first
              .data()['activities']
              .map<Activity>((activity) => Activity.fromMap(activity))
              .toList();
        }
      });
    } catch (e) {
      print(e.toString());
    }
    return activities;
  }
}
