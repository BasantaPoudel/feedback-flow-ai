import 'package:feedback_flow/screens/activities_screen.dart';
import 'package:feedback_flow/screens/activities_screen_teacher.dart';
import 'package:feedback_flow/screens/search_screen.dart';
import 'package:feedback_flow/screens/stats_screen.dart';
import 'package:feedback_flow/screens/welcome_screen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_ui_auth/firebase_ui_auth.dart';

abstract class HomeScreenState {
  int _currentIndex = 0;

  //Definition of state variables
  late List<Widget> _children = [
    WelcomeScreen(),
    Activities(),
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
}

class UserLoadingState extends HomeScreenState {}

class TeacherLoggedInState extends HomeScreenState {
  final List<Widget> _children = [
    WelcomeScreen(),
    ActivitiesTeacher(),
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
}

class StudentLoggedInState extends HomeScreenState {
  final int _currentIndex = 0;
  final List<Widget> _children = [
    WelcomeScreen(),
    Activities(),
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
}

class UserLoggedOutState extends HomeScreenState {}
