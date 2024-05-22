import 'package:feedback_flow/cubits/presenters_screen/presenters_screen_cubit.dart';
import 'package:feedback_flow/main.dart';
import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Profile extends StatefulWidget {
  // const Profile({required Key key}) : super(key: key);

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    return ProfileScreen(
      appBar: AppBar(
        title: const Text('User Profile'),
      ),
      actions: [
        EmailVerifiedAction(() {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text('Email verified')));
          RestartWidget.restartApp(context);
        }),
        DisplayNameChangedAction((context, oldName, newName) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              backgroundColor: Colors.green,
              content: Text(
                  'Display name changed to $newName, Please Sign Out and Sign In again!'),
              duration: const Duration(seconds: 3),
            ),
          );

          context.read<PresenterScreenCubit>().updateUserName(newName);
          // RestartWidget.restartApp(context);
        }),
        SignedOutAction((context) {
          RestartWidget.restartApp(context);
        })
      ],
    );
  }
}
