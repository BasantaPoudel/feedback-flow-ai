import 'package:bloc/bloc.dart';
import 'package:feedback_flow/cubits/home_screen/home_screen_state.dart';
import 'package:feedback_flow/repository/user_repository.dart';
import 'package:feedback_flow/screens/act_screen.dart';
import 'package:feedback_flow/screens/feedback_screen.dart';
import 'package:feedback_flow/screens/presenters_screen.dart';
import 'package:feedback_flow/screens/profile_screen.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreenCubit extends Cubit<HomeScreenState> {
  int _currentIndex = 0;
  final UserRepository _userRepository = UserRepository();
  final List<Widget> _commonChildren = [
    const ActivitiesScreen(),
    const FeedbackScreen(),
    // const Stats(),
    const Profile(),
  ];

  late List<Widget> _childrenStudent;
  late List<Widget> _childrenProfessor;

  HomeScreenCubit() : super(UserLoadingState()) {
    getUserRole();
    _childrenStudent = createStudentsWidgets();
    _childrenProfessor = createProfessorWidgets();
  }

  Future<void> getUserRole() async {
    String userRole = await _userRepository.getUserRole();
    if (userRole == "professor") {
      emit(ProfessorLoggedInState(_currentIndex, _childrenProfessor));
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

  List<Widget> createProfessorWidgets() {
    List<Widget> childrenProfessor = _commonChildren.toList();
    return childrenProfessor
      ..insert(
        2,
        const PresentersScreen(),
      );
  }

  List<Widget> createStudentsWidgets() {
    List<Widget> childrenStudent = _commonChildren.toList();

    return childrenStudent;
  }

  void onTabTappedProfessor(int index) {
    _currentIndex = index;
    emit(ProfessorLoggedInState(_currentIndex, _childrenProfessor));
  }

  void onTabTappedStudent(int index) {
    _currentIndex = index;
    emit(StudentLoggedInState(_currentIndex, _childrenStudent));
  }
}
