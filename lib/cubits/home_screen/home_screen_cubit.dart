import 'package:bloc/bloc.dart';
import 'package:feedback_flow/cubits/home_screen/home_screen_state.dart';
import 'package:feedback_flow/repository/user_repository.dart';
import 'package:feedback_flow/screens/activities_screen_teacher.dart';
import 'package:feedback_flow/screens/database_screen.dart';
import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:flutter/material.dart';

import 'package:feedback_flow/screens/activities_screen.dart';
import 'package:feedback_flow/screens/search_screen.dart';
import 'package:feedback_flow/screens/stats_screen.dart';
import 'package:feedback_flow/screens/welcome_screen.dart';

class HomeScreenCubit extends Cubit<HomeScreenState> {
  // static final HomeScreenCubit instance = HomeScreenCubit();
  int _currentIndex = 0;
  final UserRepository _userRepository = UserRepository();
  Future<void>? _getRole;
  //TODO - Optimize the list
  final List<Widget> _childrenTeacher = [
    const WelcomeScreen(),
    const ActivitiesTeacherScreen(),
    const DatabaseScreen(),
    const Stats(),
    ProfileScreen(
      appBar: AppBar(
        title: const Text('User Profile'),
      ),
      actions: [
        SignedOutAction((context) {
          Navigator.of(context).pop();
        })
      ],
      children: const [
        Divider(),
        Padding(
          padding: EdgeInsets.all(2),
          child: AspectRatio(
            aspectRatio: 1,
            // child: Image.asset('flutterfire_300x.png'),
          ),
        ),
      ],
    ),
  ];

  final List<Widget> _childrenStudent = [
    const WelcomeScreen(),
    ActivitiesScreen(),
    const Search(),
    const Stats(),
    ProfileScreen(
      appBar: AppBar(
        title: const Text('User Profile'),
      ),
      actions: [
        SignedOutAction((context) {
          Navigator.of(context).pop();
        })
      ],
      children: const [
        Divider(),
        Padding(
          padding: EdgeInsets.all(2),
          child: AspectRatio(
            aspectRatio: 1,
            // child: Image.asset('flutterfire_300x.png'),
          ),
        ),
      ],
    ),
  ];

  HomeScreenCubit() : super(UserLoadingState()) {
    _getRole = getUserRole();
  }

  // Consists all the business logic here
  Future<void> getUserRole() async {
    //TODO - Check How to access Future Data in right manner
    String userRole = await _userRepository.getUserRole(
        _currentIndex, _childrenTeacher, _childrenStudent);
    if (userRole == "teacher") {
      emit(TeacherLoggedInState(_currentIndex, _childrenTeacher));
    } else if (userRole == "student") {
      emit(StudentLoggedInState(_currentIndex, _childrenStudent));
    } else {
      emit(UserErrorState("Error in fetching user role"));
    }
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
