import 'package:feedback_flow/cubits/presenters_screen/presenters_screen_cubit.dart';
import 'package:feedback_flow/main.dart';
import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    return ProfileScreen(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('My Profile'),
      ),
      actions: [
        EmailVerifiedAction(() {
          ScaffoldMessenger.of(context)
              .showSnackBar(const SnackBar(content: Text('Email verified')));
          RestartWidget.restartApp(context);
        }),
        DisplayNameChangedAction((context, oldName, newName) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              backgroundColor: Colors.green,
              content: Text(
                  'Display name changed to $newName, Please Sign Out and Sign In again once you verify your email!'),
              duration: const Duration(seconds: 5),
            ),
          );
          context.read<PresenterScreenCubit>().updateUserName(newName);
        }),
        SignedOutAction((context) {
          RestartWidget.restartApp(context);
        })
      ],
      children: const [
        Center(child: Text("App Version: 0.1.0+7")),
      ],
    );
  }
}
