import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:feedback_flow/cubits/home_screen/home_screen_state.dart';
import 'package:feedback_flow/screens/activities_screen_teacher.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:flutter/material.dart';

import 'package:feedback_flow/screens/activities_screen.dart';
import 'package:feedback_flow/screens/search_screen.dart';
import 'package:feedback_flow/screens/stats_screen.dart';
import 'package:feedback_flow/screens/welcome_screen.dart';

class HomeScreenCubit extends Cubit<HomeScreenState> {
  // static final HomeScreenCubit instance = HomeScreenCubit();
  User? user = FirebaseAuth.instance.currentUser;
  var roleBasedUsersRef = FirebaseFirestore.instance.collection('role_based');
  int _currentIndex = 0;

  //TODO - Optimize the list
  List<Widget> _childrenTeacher = [
    WelcomeScreen(),
    ActivitiesTeacherScreen(),
    Search(),
    Stats(),
    ProfileScreen(
      appBar: AppBar(
        title: const Text('User Profile'),
      ),
      actions: [
        SignedOutAction((context) {
          Navigator.of(context).pop();
        })
      ],
      children: [
        const Divider(),
        Padding(
          padding: const EdgeInsets.all(2),
          child: AspectRatio(
            aspectRatio: 1,
            // child: Image.asset('flutterfire_300x.png'),
          ),
        ),
      ],
    ),
  ];

  List<Widget> _childrenStudent = [
    WelcomeScreen(),
    ActivitiesScreen(),
    Search(),
    Stats(),
    ProfileScreen(
      appBar: AppBar(
        title: const Text('User Profile'),
      ),
      actions: [
        SignedOutAction((context) {
          Navigator.of(context).pop();
        })
      ],
      children: [
        const Divider(),
        Padding(
          padding: const EdgeInsets.all(2),
          child: AspectRatio(
            aspectRatio: 1,
            // child: Image.asset('flutterfire_300x.png'),
          ),
        ),
      ],
    ),
  ];

  HomeScreenCubit() : super(UserLoadingState()) {
    getUserRole();
  }

  // Consists all the business logic here
  getUserRole() {
    final query = roleBasedUsersRef.where("email", isEqualTo: user!.email);
    //Step-2 [use get to retrieve the results]
    query.get().then(
      (querySnapshot) {
        print("Query1 - Successfully completed");
        for (var docSnapshot in querySnapshot.docs) {
          print('${docSnapshot.id} => ${docSnapshot.data()}');
          if (docSnapshot.data().containsValue("teacher")) {
            print("[Reached Teacher If]");
            emit(TeacherLoggedInState(_currentIndex, _childrenTeacher));
          } else {
            print("[Reached Student If]");
            emit(StudentLoggedInState(_currentIndex, _childrenStudent));
            // loadStudentWidgets();
          }
          ;
        }
      },
      onError: (e) => print("Error completing: $e"),
    );
  }

  logOut() {
    emit(UserLoggedOutState());
  }

  @override
  Future<void> close() {
    emit(UserLoggedOutState());
    return super.close();
  }

  void changeIndex(int index) {
    _currentIndex = index;
    // emit(TeacherLoggedInState(_currentIndex, _childrenTeacher));
  }

  void onTabTappedTeacher(int index) {
    _currentIndex = index;
    emit(TeacherLoggedInState(_currentIndex, _childrenTeacher));
  }

  void onTabTappedStudent(int index) {
    _currentIndex = index;
    emit(StudentLoggedInState(_currentIndex, _childrenStudent));
  }
}
