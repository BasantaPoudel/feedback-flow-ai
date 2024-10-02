import 'package:feedback_flow/cubits/act_screen/act_screen_cubit.dart';
import 'package:feedback_flow/cubits/presenters_screen/presenters_screen_cubit.dart';
import 'package:feedback_flow/models/activity.dart';
import 'package:feedback_flow/models/rubric.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EditActivity extends StatelessWidget {
  final _controllerTitle = TextEditingController();
  final List<TextEditingController> _textControllers = [];
  late final Activity? activity;

  EditActivity({super.key});
  EditActivity.withActivity(Activity activity, {super.key}) {
    this.activity = activity;

    _controllerTitle.text = activity.title;
    activity.rubrics.values.first.forEach((rubric) {
      final rubricController = TextEditingController();
      rubricController.text = rubric.title;
      _textControllers.add(rubricController);
    });
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
          ..._textControllers
              .map((controller) => TextField(
                    controller: controller,
                    decoration: const InputDecoration(
                      hintText: 'Enter rubric',
                      border: OutlineInputBorder(),
                    ),
                    maxLines: null,
                  ))
              .toList(),
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
            if (_controllerTitle.text.trim().isEmpty) return;

            activitiesScreenCubit.updateActivity(Activity(
              title: _controllerTitle.text,
              rubrics: {
                databaseScreenCubit.getUserId(): _textControllers
                    .map((controller) => Rubric(
                          title: controller.text,
                          score: 0,
                        ))
                    .toList(),
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
