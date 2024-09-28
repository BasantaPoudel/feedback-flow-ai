import 'package:feedback_flow/repository/user_repository.dart';
import 'package:flutter/material.dart';

class FeedbackScreen extends StatelessWidget {
  const FeedbackScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final UserRepository userrepo = UserRepository();

    return Scaffold(
        appBar: AppBar(
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Hello, ',
              ),
              Text(
                userrepo.user?.displayName ?? 'User',
              )
            ],
          ),
        ),
        body: Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Colors.grey.shade200, Colors.white],
                ),
                borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                    bottomLeft: Radius.circular(30),
                    bottomRight: Radius.circular(30))),
            child: Center(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.asset('assets/image/welcome_transparent.png'),
                    Text(
                      'Please wait for the activity to start before you can provide peer feedback',
                      style: Theme.of(context).textTheme.displayMedium,
                    ),
                  ]),
            )));
  }
}
