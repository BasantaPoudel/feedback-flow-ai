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
      showDeleteConfirmationDialog: true,
      appBar: AppBar(
        centerTitle: true,
        title: const Text('My Profile'),
      ),
      // avatar: const CircleAvatar(
      //   child: Icon(Icons.),
      // ),
      // showMFATile: true,
      actions: [
        DisplayNameChangedAction((context, oldName, newName) async {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: const Text('Name Changed'),
                content: Text('Display name changed to $newName'),
                actions: <Widget>[
                  TextButton(
                    child: const Text('OK'),
                    onPressed: () {
                      Navigator.of(context).pop(); // Close the dialog
                      RestartWidget.restartApp(context);
                    },
                  ),
                ],
              );
            },
          );
          try {
            await context.read<PresenterScreenCubit>().updateUserName(newName);
          } catch (e) {
            // ScaffoldMessenger.of(context).showSnackBar(
            //   SnackBar(
            //     content: Text('Failed to update display name in the database: $e'),
            //   ),
            // );
            print(e);
          }
        }),
        SignedOutAction((context) {
          RestartWidget.restartApp(context);
        })
      ],
      children: const [
        Center(child: Text("App Version: 0.1.0+12")),
      ],
    );
  }
}
