import 'package:feedback_flow/screens/activities_screen.dart';
import 'package:feedback_flow/screens/activities_screen_teacher.dart';
import 'package:feedback_flow/screens/search_screen.dart';
import 'package:feedback_flow/screens/stats_screen.dart';
import 'package:feedback_flow/screens/welcome_screen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_ui_auth/firebase_ui_auth.dart';

abstract class HomeScreenState {
  get children => null;
  get currentIndex => null;
}

class UserLoadingState extends HomeScreenState {}

class InitState extends HomeScreenState {}

class TeacherLoggedInState extends HomeScreenState {
  int _currentIndex;
  List<Widget> _children;
  TeacherLoggedInState(this._currentIndex, this._children);

  @override
  get children => _children;
  @override
  get currentIndex => _currentIndex;
}

class StudentLoggedInState extends HomeScreenState {
  int _currentIndex;
  List<Widget> _children;
  StudentLoggedInState(this._currentIndex, this._children);

  @override
  get children => _children;
  @override
  get currentIndex => _currentIndex;
}

class UserLoggedOutState extends HomeScreenState {}

class UserErrorState extends HomeScreenState {
  String _message;
  UserErrorState(this._message);

  get message => _message;
}

class BottomNavigationChanged extends HomeScreenState {
  int _currentIndex;
  List<Widget> _children;
  BottomNavigationChanged(this._currentIndex, this._children);

  @override
  get children => _children;
  @override
  get currentIndex => _currentIndex;
}
