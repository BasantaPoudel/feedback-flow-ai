import 'package:feedback_flow/navigation_home.dart';
import 'package:feedback_flow/screens/profile_screen.dart';
import 'package:firebase_auth/firebase_auth.dart' hide EmailAuthProvider;
import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:flutter/material.dart';

class AuthGate extends StatefulWidget {
  const AuthGate({Key? key}) : super(key: key);

  @override
  State<AuthGate> createState() => _AuthGateState();
}

class _AuthGateState extends State<AuthGate> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return SignInScreen(
            // showAuthActionSwitch: false,
            showPasswordVisibilityToggle: true,
            providers: [
              EmailAuthProvider(),
            ],
            actions: [
              AuthStateChangeAction<UserCreated>((context, state) async {
                Navigator.of(context).pushReplacement(MaterialPageRoute(
                  builder: (context) => const Profile(),
                ));
              }),
            ],

            headerBuilder: (context, constraints, shrinkOffset) {
              return const Padding(
                padding: EdgeInsets.all(20),
                child: AspectRatio(
                  aspectRatio: 1,
                ),
              );
            },
            subtitleBuilder: (context, action) {
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: action == AuthAction.signIn
                    ? const Text('Welcome to FeedbackFlow, please sign in!')
                    : const Text('Welcome to FeedbackFlow, please sign up!'),
              );
            },

            footerBuilder: (context, action) {
              return const Padding(
                  padding: EdgeInsets.only(top: 16),
                  child: Column(children: [
                    Text(
                      'By signing in, you agree to our terms and conditions.',
                      style: TextStyle(color: Colors.grey),
                    ),
                  ]));
            },
            sideBuilder: (context, shrinkOffset) {
              return const Padding(
                padding: EdgeInsets.all(20),
                child: AspectRatio(
                  aspectRatio: 1,
                ),
              );
            },
          );
        } else if (snapshot.data?.displayName != null) {
          //   else if (snapshot.data?.displayName != null &&
          // snapshot.data?.emailVerified == true) {
          return const NavigationHome();
        }
        return const Profile();
      },
    );
  }
}
