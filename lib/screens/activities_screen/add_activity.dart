import 'package:feedback_flow/cubits/activities_screen/activities_screen_cubit.dart';
import 'package:feedback_flow/models/activity.dart';
import 'package:feedback_flow/models/rubric.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddActivity extends StatelessWidget {
  final _controllerTitle = TextEditingController();
  final _controllerRubric = TextEditingController();

  @override
  Widget build(BuildContext context) {
    ActivitiesScreenCubit? activitiesScreenCubit =
        BlocProvider.of<ActivitiesScreenCubit>(context);
    return AlertDialog(
      title: const Text('Add activity'),
      content: Column(
        children: [
          TextField(
            controller: _controllerTitle,
            decoration: const InputDecoration(
              hintText: 'Enter title',
              border: OutlineInputBorder(),
            ),
            maxLines: null,
          ),
          TextField(
            controller: _controllerRubric,
            decoration: const InputDecoration(
              hintText: 'Enter rubric1',
              border: OutlineInputBorder(),
            ),
            maxLines: null,
          ),
          TextField(
            controller: _controllerRubric,
            decoration: const InputDecoration(
              hintText: 'Enter rubric2',
              border: OutlineInputBorder(),
            ),
            maxLines: null,
          ),
        ],
      ),
      actions: [
        TextButton(
          child: const Text('Cancel'),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        TextButton(
          onPressed: () {
            if (_controllerRubric.text.trim().isEmpty) return;
            activitiesScreenCubit.addActivity(Activity(
              title: _controllerTitle.text,
              rubrics: [
                Rubric(
                  name: _controllerRubric.text,
                  score: 0,
                ),
              ],
              isStarted: false,
              isCompleted: false,
              isDistributed: false,
            ));
            Navigator.of(context).pop();
          },
          child: const Text('Add activity'),
        ),
      ],
    );
  }
}
