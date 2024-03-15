import 'package:feedback_flow/cubits/home_screen/home_screen_cubit.dart';
import 'package:feedback_flow/cubits/home_screen/home_screen_state.dart';
import 'package:feedback_flow/screens/activities_screen.dart';
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
  int _currentIndex = 0;

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

  @override
  void initState() {
    // User? user = FirebaseAuth.instance.currentUser;
    //Step-1 [Create query object]
    // var roleBasedUsersRef = FirebaseFirestore.instance.collection('role_based');
    // final query = roleBasedUsersRef.where("email", isEqualTo: user!.email);

    //Step-2 [use get to retrieve the results]
    // query.get().then(
    //   (querySnapshot) {
    //     print("Query1 - Successfully completed");
    //     for (var docSnapshot in querySnapshot.docs) {
    //       print('${docSnapshot.id} => ${docSnapshot.data()}');
    //       if (docSnapshot.data().containsValue("teacher")) {
    //         print("[Reached Teacher If]");
    //         _children = [
    //           WelcomeScreen(),
    //           ActivitiesTeacher(),
    //           Search(),
    //           Stats(),
    //           ProfileScreen(
    //             appBar: AppBar(
    //               title: const Text('User Profile'),
    //             ),
    //             actions: [
    //               SignedOutAction((context) {
    //                 Navigator.of(context).pop();
    //               })
    //             ],
    //             children: [
    //               const Divider(),
    //               Padding(
    //                 padding: const EdgeInsets.all(2),
    //                 child: AspectRatio(
    //                   aspectRatio: 1,
    //                   // child: Image.asset('flutterfire_300x.png'),
    //                 ),
    //               ),
    //             ],
    //           ),
    //         ];
    //       } else {
    //         _children = [
    //           WelcomeScreen(),
    //           Activities(),
    //           Search(),
    //           Stats(),
    //           ProfileScreen(
    //             appBar: AppBar(
    //               title: const Text('User Profile'),
    //             ),
    //             actions: [
    //               SignedOutAction((context) {
    //                 Navigator.of(context).pop();
    //               })
    //             ],
    //             children: [
    //               const Divider(),
    //               Padding(
    //                 padding: const EdgeInsets.all(2),
    //                 child: AspectRatio(
    //                   aspectRatio: 1,
    //                   // child: Image.asset('flutterfire_300x.png'),
    //                 ),
    //               ),
    //             ],
    //           ),
    //         ];
    //         print("[Reached Student If]");
    //         // loadStudentWidgets();
    //       }
    //       ;
    //     }
    //   },
    //   onError: (e) => print("Error completing: $e"),
    // );
    super.initState();
  }

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<HomeScreenCubit, HomeScreenState>(
          builder: (context, state) {
        if (state is UserLoadingState) {
          return CircularProgressIndicator();
        } else if (state is TeacherLoggedInState ||
            state is StudentLoggedInState) {
          return _children[_currentIndex];
        } else
          return Center(
            child: Text("Something went wrong"),
          );
      }),
      bottomNavigationBar: BottomNavigationBar(
        onTap: onTabTapped,
        currentIndex: _currentIndex,
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
      ),
    );
  }
}
