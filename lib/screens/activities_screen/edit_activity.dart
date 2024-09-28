import 'package:feedback_flow/cubits/act_screen/act_screen_cubit.dart';
import 'package:feedback_flow/cubits/presenters_screen/presenters_screen_cubit.dart';
import 'package:feedback_flow/models/activity.dart';
import 'package:feedback_flow/models/rubric.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EditActivity extends StatelessWidget {
  final _controllerTitle = TextEditingController();
  final _controllerRubric1 = TextEditingController();
  final _controllerRubric2 = TextEditingController();
  late final Activity? activity;

  EditActivity({super.key});
  EditActivity.withActivity(Activity activity, {super.key}) {
    this.activity = activity;
    _controllerTitle.text = activity.title;
    _controllerRubric1.text = activity.rubrics.values.first.first.title;
    _controllerRubric2.text = activity.rubrics.values.first.last.title;
  }

  @override
  Widget build(BuildContext context) {
    ActScreenCubit? activitiesScreenCubit =
        BlocProvider.of<ActScreenCubit>(context);

    PresenterScreenCubit? databaseScreenCubit =
        BlocProvider.of<PresenterScreenCubit>(context);

    return AlertDialog(
      title: const Text('Edit activity'),
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
            controller: _controllerRubric1,
            decoration: const InputDecoration(
              hintText: 'Enter rubric1',
              border: OutlineInputBorder(),
            ),
            maxLines: null,
          ),
          TextField(
            controller: _controllerRubric2,
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
            if (_controllerRubric1.text.trim().isEmpty) return;

            activitiesScreenCubit.updateActivity(Activity(
              title: _controllerTitle.text,
              rubrics: {
                databaseScreenCubit.getUserId(): [
                  Rubric(
                    title: _controllerRubric1.text,
                    score: 0,
                  ),
                  Rubric(
                    title: _controllerRubric2.text,
                    score: 0,
                  ),
                ],
              },
              isStarted: false,
              isCompleted: false,
              isDistributed: false,
            ));
            Navigator.of(context).pop();
          },
          child: const Text('Edit activity'),
        ),
      ],
    );
  }
}
