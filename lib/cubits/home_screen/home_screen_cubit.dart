import 'package:bloc/bloc.dart';
import 'package:feedback_flow/cubits/home_screen/home_screen_state.dart';
import 'package:feedback_flow/repository/user_repository.dart';
import 'package:feedback_flow/screens/act_screen.dart';
import 'package:feedback_flow/screens/feedback_screen.dart';
import 'package:feedback_flow/screens/presenters_screen.dart';
import 'package:feedback_flow/screens/profile_screen.dart';
import 'package:flutter/material.dart';

import 'package:feedback_flow/screens/stats_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreenCubit extends Cubit<HomeScreenState> {
  int _currentIndex = 0;
  final UserRepository _userRepository = UserRepository();
  final List<Widget> _commonChildren = [
    const ActivitiesScreen(),
    const FeedbackScreen(),
    const Stats(),
    const Profile(),
  ];

  late List<Widget> _childrenStudent;
  late List<Widget> _childrenTeacher;

  HomeScreenCubit() : super(UserLoadingState()) {
    getUserRole();
    _childrenStudent = createStudentsWidgets();
    _childrenTeacher = createTeacherWidgets();
  }

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
        2,
        const PresentersScreen(),
      );
  }

  List<Widget> createStudentsWidgets() {
    List<Widget> childrenStudent = _commonChildren.toList();

    return childrenStudent;
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
