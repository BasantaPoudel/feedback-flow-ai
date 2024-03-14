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

  List<Widget> _children = [
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

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  void loadTeacherWidgets() {
    setState(() {
      _children = [
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
    });
  }

  void loadStudentWidgets() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    User? user = FirebaseAuth.instance.currentUser;

    //get list of role based users
    var role_based_users = FirebaseFirestore.instance.collection('role_based');

    //try adding some users to the database
    final new_user = <String, dynamic>{
      "role": "student",
      "email": "welcomesarad@gmail.com"
    };

    final new_user2 = <String, dynamic>{
      "role": "teacher",
      "email": "claudia@gmail.com"
    };

    // Adding Successful
    // role_based_users.doc("sharad").set(new_user);
    // role_based_users.add(new_user2);

    //Perform Simple Query
    //Step-1 [Create query object]
    var roleBasedUsersRef = FirebaseFirestore.instance.collection('role_based');
    final query = roleBasedUsersRef.where("email", isEqualTo: user!.email);

    //Step-2 [use get to retrieve the results]
    query.get().then(
      (querySnapshot) {
        print("Query1 - Successfully completed");
        for (var docSnapshot in querySnapshot.docs) {
          print('${docSnapshot.id} => ${docSnapshot.data()}');
          if (docSnapshot.data().containsValue("teacher")) {
            print("[Reached Teacher If]");
            // loadTeacherWidgets();
          } else {
            print("[Reached Student If]");
            // loadStudentWidgets();
          }
          ;
        }
      },
      onError: (e) => print("Error completing: $e"),
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
