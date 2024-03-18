import 'package:feedback_flow/cubits/home_screen/home_screen_cubit.dart';
import 'package:feedback_flow/cubits/home_screen/home_screen_state.dart';
import 'package:feedback_flow/screens/activities_screen.dart';
import 'package:feedback_flow/screens/activities_screen_teacher.dart';
import 'package:feedback_flow/screens/search_screen.dart';
import 'package:feedback_flow/screens/stats_screen.dart';
import 'package:feedback_flow/screens/welcome_screen.dart';
import 'package:flutter/material.dart';

import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // HomeScreenCubit homeScreenCubit = HomeScreenCubit.instance;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    //TODO - Fix the Cubit
    return BlocProvider(
        create: (_) => HomeScreenCubit(),
        child: Scaffold(body: BlocBuilder<HomeScreenCubit, HomeScreenState>(
            builder: (context, state) {
          if (state is UserLoadingState) {
            return Center(child: CircularProgressIndicator());
          } else if (state is TeacherLoggedInState ||
              state is StudentLoggedInState) {
            final currentIndex = state.currentIndex;
            final children = state.children;
            return children[currentIndex];
          } else
            return Center(
              child: Text("Something went wrong"),
            );
        }), bottomNavigationBar: BlocBuilder<HomeScreenCubit, HomeScreenState>(
            builder: (context, state) {
          if (state is UserLoadingState) {
            return Center(child: CircularProgressIndicator());
          } else if (state is TeacherLoggedInState) {
            return BottomNavigationBar(
              onTap: context.read<HomeScreenCubit>().onTabTappedTeacher,
              currentIndex: state.currentIndex,
              type: BottomNavigationBarType.fixed,
              items: const [
                BottomNavigationBarItem(
                  icon: Icon(Icons.home),
                  label: 'Home',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.cloud),
                  label: 'Feedback',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.data_object_sharp),
                  label: 'Database',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.bar_chart),
                  label: 'Stats',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.person),
                  label: 'Profile',
                ),
              ],
            );
          } else if (state is StudentLoggedInState) {
            return BottomNavigationBar(
              onTap: context.read<HomeScreenCubit>().onTabTappedStudent,
              currentIndex: state.currentIndex,
              type: BottomNavigationBarType.fixed,
              items: const [
                BottomNavigationBarItem(
                  icon: Icon(Icons.home),
                  label: 'Home',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.cloud),
                  label: 'Feedback',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.search),
                  label: 'Search',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.bar_chart),
                  label: 'Stats',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.person),
                  label: 'Profile',
                ),
              ],
            );
          } else
            return Center(
              child: Text("Something went wrong"),
            );
        })));
  }
}
