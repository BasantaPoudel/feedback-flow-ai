import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:feedback_flow/models/user.dart';
import 'package:feedback_flow/repository/main_repository.dart';
import 'package:flutter/widgets.dart';

class UserRepository extends MainRepository {
  List<UserModel> users = [];

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
      print('Error: $e');
    }
    return users;
  }

  Future<String> getUserRole(int currentIndex, List<Widget> childrenTeacher,
      List<Widget> childrenStudent) async {
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
}
