import 'package:bloc/bloc.dart';
import 'package:feedback_flow/cubits/home_screen/home_screen_state.dart';
import 'package:feedback_flow/repository/user_repository.dart';
import 'package:feedback_flow/screens/act_screen.dart';
import 'package:feedback_flow/screens/activities_screen_teacher.dart';
import 'package:feedback_flow/screens/database_screen.dart';
import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:flutter/material.dart';

import 'package:feedback_flow/screens/activities_screen.dart';
import 'package:feedback_flow/screens/search_screen.dart';
import 'package:feedback_flow/screens/stats_screen.dart';

class HomeScreenCubit extends Cubit<HomeScreenState> {
  int _currentIndex = 0;
  final UserRepository _userRepository = UserRepository();
  final List<Widget> _commonChildren = [
    const ActScreen(),
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

  late List<Widget> _childrenStudent;
  late List<Widget> _childrenTeacher;

  HomeScreenCubit() : super(UserLoadingState()) {
    getUserRole();
    _childrenStudent = createStudentsWidgets();
    _childrenTeacher = createTeacherWidgets();
  }

  // Consists all the business logic here
  Future<void> getUserRole() async {
    String userRole = await _userRepository.getUserRole();
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
  }

  List<Widget> createTeacherWidgets() {
    List<Widget> childrenTeacher = _commonChildren.toList();
    return childrenTeacher
      ..insert(
        1,
        const ActivitiesTeacherScreen(),
      )
      ..insert(
        2,
        const DatabaseScreen(),
      );
  }

  List<Widget> createStudentsWidgets() {
    List<Widget> childrenStudent = _commonChildren.toList();

    return childrenStudent
      ..insert(
        1,
        const ActivitiesScreen(),
      )
      ..insert(
        2,
        const Search(),
      );
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
