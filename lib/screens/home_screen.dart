import 'package:feedback_flow/auth_gate.dart';
import 'package:feedback_flow/cubits/home_screen/home_screen_cubit.dart';
import 'package:feedback_flow/cubits/home_screen/home_screen_state.dart';
import 'package:flutter/material.dart';
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
            return const Center(child: CircularProgressIndicator());
          } else if (state is TeacherLoggedInState ||
              state is StudentLoggedInState) {
            final currentIndex = state.currentIndex;
            final children = state.children;
            return children[currentIndex];
          } else {
            return const Center(
              child: Text("Something went wrong Initial State"),
            );
          }
        }), bottomNavigationBar: BlocBuilder<HomeScreenCubit, HomeScreenState>(
            builder: (context, state) {
          if (state is UserLoadingState) {
            return const Center(child: CircularProgressIndicator());
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
                  icon: Icon(Icons.present_to_all),
                  label: 'Activities',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.data_object_sharp),
                  label: 'Presenters',
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
                  icon: Icon(Icons.present_to_all),
                  label: 'Activities',
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
          } else {
            // ScaffoldMessenger.of(context).showSnackBar(
            //   const SnackBar(content: Text('Failed to load items')),
            // );
            //TODO - Temporary method to get out of blockade
            return ElevatedButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => AuthGate(),
                      ));
                },
                child: Text("Retry Logging In"));
          }
        })));
  }
}
