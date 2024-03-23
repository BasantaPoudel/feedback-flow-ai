import 'package:feedback_flow/repository/main_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ScoreRepository extends MainRepository {
  @override
  User? user = FirebaseAuth.instance.currentUser;

  void sendScoreToFirebase(presenter) {
    // Send the score to Firebase database
    databaseRef.where("provider", isEqualTo: user!.email).get().then((value) {
      if (value.docs.isEmpty) {
        databaseRef.add({
          'provider': user!.email,
          'score1': presenter.activities![0].rubrics[0].score,
          'score2': presenter.activities![0].rubrics[1].score,
        });
      } else {
        databaseRef.doc(value.docs.first.id).update({
          'score1': presenter.activities![0].rubrics[0].score,
          'score2': presenter.activities![0].rubrics[1].score
        });
      }
    });
  }
}
