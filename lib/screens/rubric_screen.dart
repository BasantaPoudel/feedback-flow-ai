import 'package:feedback_flow/cubits/act_screen/act_screen_cubit.dart';
import 'package:feedback_flow/cubits/act_screen/act_screen_state.dart';
import 'package:feedback_flow/cubits/home_screen/home_screen_cubit.dart';
import 'package:feedback_flow/cubits/home_screen/home_screen_state.dart';
import 'package:feedback_flow/cubits/presenters_screen/presenters_screen_cubit.dart';
import 'package:feedback_flow/cubits/presenters_screen/presenters_screen_state.dart';
import 'package:feedback_flow/cubits/rubric_screen/rubric_screen_cubit.dart';
import 'package:feedback_flow/cubits/rubric_screen/rubric_screen_state.dart';
import 'package:feedback_flow/models/activity.dart';
import 'package:feedback_flow/models/rubric.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RubricScreen extends StatefulWidget {
  final Activity activity;
  const RubricScreen({super.key, required this.activity});

  @override
  State<RubricScreen> createState() => _RubricScreenState();
}

class _RubricScreenState extends State<RubricScreen> {
  final _controllerNewRubric = TextEditingController();
  final _controllerDescription = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    PresenterScreenCubit? presentersScreenCubit =
        BlocProvider.of<PresenterScreenCubit>(context);

    HomeScreenCubit? homeScreenCubit =
        BlocProvider.of<HomeScreenCubit>(context);

    return BlocBuilder<RubricScreenCubit, RubricScreenState>(
        builder: (context, stateRubric) {
      if (stateRubric is RubricScreenInitial) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      }
      return BlocBuilder<ActScreenCubit, ActScreenState>(
          builder: (context, stateActivity) {
        return Scaffold(
          appBar: AppBar(
            title: const Text("Rubrics List"),
          ),
          body: ListView(children: <Widget>[
            ListTile(
              title: Text(stateRubric.activity.title),
              subtitle: ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount:
                    stateRubric.activity.rubrics.entries.first.value.length,
                itemBuilder: (BuildContext context, int index) {
                  return ListTile(
                    title: Text(
                      stateRubric.activity.rubrics.entries.first.value
                          .elementAt(index)
                          .title,
                    ),
                    subtitle: Text(
                      stateRubric.activity.rubrics.entries.first.value
                          .elementAt(index)
                          .description,
                    ),
                    trailing: (homeScreenCubit.state is TeacherLoggedInState &&
                            stateActivity is! ActivityStarted)
                        ? IconButton(
                            icon: const Icon(Icons.delete),
                            onPressed: () {
                              context.read<ActScreenCubit>().deleteRubric(
                                  stateRubric.activity,
                                  stateRubric
                                      .activity.rubrics.entries.first.value
                                      .elementAt(index));
                            },
                          )
                        : null,
                  );
                },
              ),
            ),
            if (stateActivity is ActivityStarted &&
                stateRubric.activity.isStarted &&
                presentersScreenCubit.state is PresenterState)
              Container(
                padding: const EdgeInsets.all(30),
                child: Text(
                    "Activity has started and you can provide feedback from the Feedback Menu",
                    style: Theme.of(context)
                        .textTheme
                        .titleLarge), //TODO - Check the theme
              ),
          ]),
        );
      });
      // return const FittedBox();
    });
  }

  //TODO - Check types of Dialog available
  Future<void> showAlertDialog(BuildContext context, stateRubric) async {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Add Rubric'),
            content: Column(
              children: [
                TextField(
                  controller: _controllerNewRubric,
                  decoration: const InputDecoration(
                    hintText: 'Enter rubric title',
                    border: OutlineInputBorder(),
                  ),
                  maxLines: null,
                ),
                TextField(
                  controller: _controllerDescription,
                  decoration: const InputDecoration(
                    hintText: 'Enter rubric description',
                    border: OutlineInputBorder(),
                  ),
                  maxLines: null,
                )
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
                  if (_controllerNewRubric.text.trim().isEmpty) return;
                  context.read<ActScreenCubit>().addRubric(
                      stateRubric.activity,
                      Rubric(
                        title: _controllerNewRubric.text,
                        score: 0,
                        description: _controllerDescription.text,
                      ));
                  Navigator.of(context).pop();
                },
                child: const Text('Add Rubric'),
              ),
            ],
          );
        });
  }
}
