import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:feedback_flow/models/activity.dart';
import 'package:feedback_flow/repository/main_repository.dart';
import 'package:logger/web.dart';

class ActivityRepository extends MainRepository {
  final activitiesRef = FirebaseFirestore.instance.collection('act');
  final Logger log = Logger();
  //Method to call when adding an activity by the professor
  void addActivity(activity) {
    try {
      activitiesRef.add(activity.toMap());
    } catch (e) {
      log.d(e);
    }
  }

  //Method to call when changing the status of an activity
  updateActivity(Activity activity) async {
    try {
      activitiesRef.doc(activity.id).update(activity.toMap());
    } catch (e) {
      log.d('Error: $e');
    }
  }

  void deleteActivity(Activity activity) {
    try {
      activitiesRef.doc(activity.id).delete();
    } catch (e) {
      log.d('Error: $e');
    }
  }
}
