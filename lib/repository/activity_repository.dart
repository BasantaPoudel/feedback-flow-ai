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
      log.d('Error: $e');
    }
  }

  void deleteActivity(Activity activity) {
    try {
      final query = activitiesRef.where("title", isEqualTo: activity.title);
      query.get().then((querySnapshot) {
        for (var doc in querySnapshot.docs) {
          doc.reference.delete();
        }
      });
    } catch (e) {
      log.d('Error: $e');
    }
  }
}
