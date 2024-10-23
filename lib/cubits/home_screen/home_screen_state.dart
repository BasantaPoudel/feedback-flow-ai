import 'package:flutter/material.dart';

abstract class HomeScreenState {
  get children => null;
  get currentIndex => null;
}

class UserLoadingState extends HomeScreenState {}

class InitState extends HomeScreenState {}

class ProfessorLoggedInState extends HomeScreenState {
  final int _currentIndex;
  final List<Widget> _children;
  ProfessorLoggedInState(this._currentIndex, this._children);

  @override
  get children => _children;
  @override
  get currentIndex => _currentIndex;
}

class StudentLoggedInState extends HomeScreenState {
  final int _currentIndex;
  final List<Widget> _children;
  StudentLoggedInState(this._currentIndex, this._children);

  @override
  get children => _children;
  @override
  get currentIndex => _currentIndex;
}

class UserLoggedOutState extends HomeScreenState {}

class UserErrorState extends HomeScreenState {
  final String _message;
  UserErrorState(this._message);

  get message => _message;
}

class BottomNavigationChanged extends HomeScreenState {
  final int _currentIndex;
  final List<Widget> _children;
  BottomNavigationChanged(this._currentIndex, this._children);

  @override
  get children => _children;
  @override
  get currentIndex => _currentIndex;
}
