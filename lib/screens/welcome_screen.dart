import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:flutter/material.dart';

class WelcomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('FeedbackFlow'),
          automaticallyImplyLeading: false,
        ),
        body: Center(
          child: Column(
            children: [
              Image.asset('assets/image/welcome_transparent.png'),
              Text(
                'Welcome!',
                style: Theme.of(context).textTheme.displaySmall,
              ),
              const SignOutButton(),
            ],
          ),
        ));
  }
}
