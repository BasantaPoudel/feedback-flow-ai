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
      throw Exception('Error adding activity: $e');
    }
  }

  //Method to call when changing the status of an activity
  updateActivity(Activity activity) async {
    try {
      activitiesRef.doc(activity.id).update(activity.toMap());
    } catch (e) {
      throw Exception('Error updating activity: $e');
      // log.d('Error: $e');
    }
  }

  void deleteActivity(Activity activity) {
    try {
      activitiesRef.doc(activity.id).delete();
    } catch (e) {
      throw Exception('Error deleting activity: $e');
    }
  }

  updateActivityStatus(Activity activity) async {
    try {
      activitiesRef.doc(activity.id).update({
        'isStarted': activity.isStarted,
        'isDistributed': activity.isDistributed,
        'isCompleted': activity.isCompleted,
      });
    } catch (e) {
      throw Exception('Error updating activity status: $e');
      // log.d('Error: $e');
    }
  }
}
