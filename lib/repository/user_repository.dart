import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:feedback_flow/models/activity.dart';
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

  updateUser(UserModel user) async {
    try {
      final query = roleBasedUsersRef.where("email", isEqualTo: user.email);
      var querySnapshot = await query.get();

      for (var snapshot in querySnapshot.docs) {
        var documentID = snapshot.id;
        roleBasedUsersRef
            .doc(documentID)
            .update(user.toMap()); // <-- Document ID
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  Future<String> getUserRole() async {
    final query = roleBasedUsersRef.where("email", isEqualTo: user!.email);
    //Step-2 [use get to retrieve the results]
    try {
      var querySnapshot = await query.get();
      print("Query1 - Successfully completed");
      for (var docSnapshot in querySnapshot.docs) {
        print('${docSnapshot.id} => ${docSnapshot.data()}');
        if (docSnapshot.data().containsValue("teacher")) {
          print("[Reached Teacher If]");
          return "teacher";
        } else {
          print("[Reached Student If]");
          return "student";
        }
      }
    } catch (e) {
      print('Error: $e');
      return "error";
    }
    return "error";
  }

  Future<String> getLoggedInUserId() async {
    return user!.uid;
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
      print(e.toString());
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
      print(e.toString());
    }
    return activities;
  }
}
