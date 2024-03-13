import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:feedback_flow/screens/activities_screen.dart';
import 'package:feedback_flow/screens/activities_screen_teacher.dart';
import 'package:feedback_flow/screens/feedback_screen.dart';
import 'package:feedback_flow/screens/profile_screen.dart';
import 'package:feedback_flow/screens/search_screen.dart';
import 'package:feedback_flow/screens/stats_screen.dart';
import 'package:feedback_flow/screens/welcome_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:flutter/material.dart';

import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:flutter/material.dart';

// class HomeScreen extends StatelessWidget {
//   const HomeScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Center(
//         child: Column(
//           children: [
//             Image.asset('dash.png'),
//             Text(
//               'Welcome!',
//               style: Theme.of(context).textTheme.displaySmall,
//             ),
//             const SignOutButton(),
//           ],
//         ),
//       ),
//     );
//   }
// }

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;

  final List<Widget> _children = [
    //TODO - Attempt to add a welcome screen
    WelcomeScreen(),
    Activities(),
    Search(),
    Stats(),
    // Profile(),
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

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    User? user = FirebaseAuth.instance.currentUser;
    var firebaseDataRef = FirebaseFirestore.instance.collection('role_based');
    final query = firebaseDataRef.where('email', isEqualTo: user!.email);
    query.get().then(
      (QuerySnapshot documentSnapshot) {
        // if (documentSnapshot.exists) {
        //   if (documentSnapshot.get('role') == "student") {
        //     print("AUTH GATE: Student");
        //   }
        // }
        final data = documentSnapshot.docs.first as Map<String, dynamic>;
        final role = data['role'];
        print("Role: $role");
        for (var value in data.values) {
          print("Value: $value");
        }

        if (role == "student") {
          _children.clear();
          _children.addAll([
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
          ]);
        } else {
          _children.clear();
          _children.addAll([
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
          ]);
        }
        // ...
      },
      onError: (e) => print("Error getting document: $e"),
    );

    return Scaffold(
      body: _children[_currentIndex],
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
