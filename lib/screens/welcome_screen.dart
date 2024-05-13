import 'package:feedback_flow/repository/user_repository.dart';
import 'package:flutter/material.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final UserRepository userrepo = UserRepository();
    return Scaffold(
        backgroundColor: Colors.blue,
        appBar: AppBar(
          backgroundColor: Colors.blue,
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Hi, ',
                style: TextStyle(color: Colors.white),
              ),
              Text(
                userrepo.user?.displayName ?? 'User',
                style: TextStyle(color: Colors.white),
              )
            ],
          ),
        ),
        body: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Colors.grey.shade300, Colors.white],
              ),
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30), topRight: Radius.circular(30)),
            ),
            child: Center(
              child: Column(
                children: [
                  Image.asset('assets/image/welcome_transparent.png'),
                  Center(
                      child: Column(
                          // mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                        Text(
                          'Welcome to the FeedbackFlow!',
                          style: Theme.of(context).textTheme.headline4,
                        ),
                        Text(
                          'Please find the current activity and provide peer feedback',
                          style: Theme.of(context).textTheme.labelLarge,
                        ),
                      ])),
                  // const SignOutButton(),
                ],
              ),
            )));
  }
}
