import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:feedback_flow/models/activity.dart';
import 'package:feedback_flow/models/rubric.dart';
import 'package:feedback_flow/models/user.dart';
import 'package:feedback_flow/repository/main_repository.dart';
import 'package:logger/web.dart';

class UserRepository extends MainRepository {
  List<UserModel> users = [];
  Logger log = Logger();
  final roleBasedUsersRef = FirebaseFirestore.instance.collection('role_based');

  Future<List<UserModel>> fetchUsersFromDatabase() async {
    try {
      await roleBasedUsersRef.get().then((QuerySnapshot querySnapshot) async {
        for (var doc in querySnapshot.docs) {
          Map<String, dynamic> user = doc.data()! as Map<String, dynamic>;
          if (user['role'] == 'student') {
            users.add(UserModel.fromMap(user));
          }
        }
      });
    } catch (e) {
      log.d(e.toString());
    }
    return users;
  }

  Future<void> addUserToFirestore(UserModel? user) async {
    if (user == null) return;

    final query = roleBasedUsersRef.where("email", isEqualTo: user.email);
    var querySnapshot = await query.get();

    if (querySnapshot.docs.isEmpty) {
      roleBasedUsersRef.add(user.toMap());
    }
  }

  updateUser(UserModel user) async {
    FirebaseFirestore.instance.runTransaction((transaction) async {
      final query = roleBasedUsersRef.where("email", isEqualTo: user.email);
      var querySnapshot = await query.get();
      for (var snap in querySnapshot.docs) {
        var documentID = snap.id;

        DocumentReference docRef = roleBasedUsersRef.doc(documentID);

        // Get the document snapshot
        DocumentSnapshot snapshot = await transaction.get(docRef);

        //Get the current value
        var currentValue = snapshot.data();

        // currentValue["rubrics"] = user.rubrics;
        log.d("Current Value: $currentValue");
        log.d("Current Value: ${user.toMap()}");

        // Check if the document exists and then update it
        transaction.update(docRef, user.toMap());
      }
    }).catchError((error) {
      log.d("Transaction failed: $error");
    });
  }

  Future<String> getUserRole() async {
    final query = roleBasedUsersRef.where("email", isEqualTo: user!.email);
    //Step-2 [use get to retrieve the results]
    try {
      var querySnapshot = await query.get();
      log.d("Query1 - Successfully completed");
      for (var docSnapshot in querySnapshot.docs) {
        log.d('${docSnapshot.id} => ${docSnapshot.data()}');
        if (docSnapshot.data().containsValue("teacher")) {
          log.d("[Reached Teacher If]");
          return "teacher";
        } else {
          log.d("[Reached Student If]");
          return "student";
        }
      }
    } catch (e) {
      log.d('Error: $e');
      return "error";
    }
    return "error";
  }

  Future<String> getLoggedInUserId() async {
    return user!.uid;
  }

  getLoggedInUserAsUserModel() {
    return UserModel(
      name: user!.displayName!,
      email: user!.email!,
      role: "student",
      isPresenter: false,
    );
  }

//Method to be called when Teacher presses Start on the activity
  void addActivityWithDefaultRubricToPresenter(presenter, activity) async {
    try {
      roleBasedUsersRef
          .where("email", isEqualTo: presenter!.email)
          .get()
          .then((value) {
        if (value.docs.isNotEmpty) {
          presenter.activities ??= [];
          presenter.activities!.add(activity);

          roleBasedUsersRef.doc(value.docs.first.id).update({
            'activities': presenter.activities!
                .map((activity) => activity.toMap())
                .toList(),
          });
        }
      });
    } catch (e) {
      log.d(e.toString());
    }
  }

//Method to be called on Results Screen to get the activities of the logged in user
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
      log.d(e.toString());
    }
    return activities;
  }

  void updateRubrics(List<Rubric> rubricsFromUser, presenter, title) async {
    String uId = await getLoggedInUserId();
    FirebaseFirestore.instance.runTransaction((transaction) async {
      final query =
          roleBasedUsersRef.where("email", isEqualTo: presenter.email);
      var querySnapshot = await query.get();
      for (var snap in querySnapshot.docs) {
        var documentID = snap.id;

        DocumentReference docRef = roleBasedUsersRef.doc(documentID);

        // Get the document snapshot
        DocumentSnapshot snapshot = await transaction.get(docRef);

        //Get the current value
        var currentValue = snapshot.data() as Map<String, dynamic>;

        var index = currentValue['activities']
            .indexWhere((element) => element['title'] == title);
        var activities = currentValue['activities'];

        var currentRubrics = activities[index]['rubrics'];
        currentRubrics[uId] =
            rubricsFromUser.map((rubric) => rubric.toMap()).toList();
        activities[index]['rubrics'] = currentRubrics;

        // Check if the document exists and then update it
        log.d("UpdatedActivity: $activities");
        transaction.update(docRef, {"activities": activities});
      }
    }).catchError((error) {
      log.d("Transaction failed: $error");
    });
  }
}
