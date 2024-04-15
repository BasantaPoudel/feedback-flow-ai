import 'package:feedback_flow/repository/main_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ActivityRepository extends MainRepository {
  @override
  User? user = FirebaseAuth.instance.currentUser;

  void addActivity(activity) {
    // Send the score to Firebase database
    try {
      activitiesRef.add(activity.toMap());
    } catch (e) {
      print(e);
    }

    //   scoreRef.where("provider", isEqualTo: user!.email).get().then((value) {
    //     if (value.docs.isEmpty) {
    //       scoreRef.add({
    //         'provider': user!.email,
    //         'score1': presenter.activities![0].rubrics[0].score,
    //         'score2': presenter.activities![0].rubrics[1].score,
    //       });
    //     } else {
    //       scoreRef.doc(value.docs.first.id).update({
    //         'score1': presenter.activities![0].rubrics[0].score,
    //         'score2': presenter.activities![0].rubrics[1].score
    //       });
    //     }
    //   });
  }
}
