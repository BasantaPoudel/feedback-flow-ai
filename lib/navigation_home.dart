import 'package:feedback_flow/auth_gate.dart';
import 'package:feedback_flow/cubits/home_screen/home_screen_cubit.dart';
import 'package:feedback_flow/cubits/home_screen/home_screen_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

class NavigationHome extends StatefulWidget {
  const NavigationHome({Key? key}) : super(key: key);

  @override
  _NavigationHomeState createState() => _NavigationHomeState();
}

class _NavigationHomeState extends State<NavigationHome> {
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
            return Container(
              child: BottomNavigationBar(
                onTap: context.read<HomeScreenCubit>().onTabTappedTeacher,
                currentIndex: state.currentIndex,
                type: BottomNavigationBarType.fixed,
                items: [
                  BottomNavigationBarItem(
                    icon: SvgPicture.asset('assets/icons/home.svg'),
                    activeIcon: SvgPicture.asset('assets/icons/home_.svg'),
                    label: '',
                  ),
                  BottomNavigationBarItem(
                    icon: SvgPicture.asset('assets/icons/feedback.svg'),
                    activeIcon: SvgPicture.asset('assets/icons/feedback_.svg'),
                    label: '',
                  ),
                  BottomNavigationBarItem(
                    icon: SvgPicture.asset('assets/icons/presenters.svg'),
                    activeIcon:
                        SvgPicture.asset('assets/icons/presenters_.svg'),
                    label: '',
                  ),
                  BottomNavigationBarItem(
                    icon: SvgPicture.asset('assets/icons/stats.svg'),
                    activeIcon: SvgPicture.asset('assets/icons/stats_.svg'),
                    label: '',
                  ),
                  BottomNavigationBarItem(
                    icon: SvgPicture.asset('assets/icons/profile.svg'),
                    activeIcon: SvgPicture.asset('assets/icons/profile_.svg'),
                    label: '',
                  ),
                ],
              ),
            );
          } else if (state is StudentLoggedInState) {
            return BottomNavigationBar(
              onTap: context.read<HomeScreenCubit>().onTabTappedStudent,
              currentIndex: state.currentIndex,
              type: BottomNavigationBarType.fixed,
              items: [
                BottomNavigationBarItem(
                  icon: SvgPicture.asset('assets/icons/home.svg'),
                  activeIcon: SvgPicture.asset('assets/icons/home_.svg'),
                  label: '',
                ),
                BottomNavigationBarItem(
                  icon: SvgPicture.asset('assets/icons/feedback.svg'),
                  activeIcon: SvgPicture.asset('assets/icons/feedback_.svg'),
                  label: '',
                ),
                BottomNavigationBarItem(
                  icon: SvgPicture.asset('assets/icons/stats.svg'),
                  activeIcon: SvgPicture.asset('assets/icons/stats_.svg'),
                  label: '',
                ),
                BottomNavigationBarItem(
                  icon: SvgPicture.asset('assets/icons/profile.svg'),
                  activeIcon: SvgPicture.asset('assets/icons/profile_.svg'),
                  label: '',
                ),
              ],
            );
          } else {
            //TODO - Temporary method to get out of blockade
            return ElevatedButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const AuthGate(),
                      ));
                },
                child: const Text("Retry Logging In"));
          }
        })));
  }
}
