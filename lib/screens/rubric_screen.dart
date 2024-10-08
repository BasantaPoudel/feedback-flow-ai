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
        if (stateActivity is ActivityStarted &&
            stateRubric.activity.isStarted &&
            presentersScreenCubit.state is PresenterState) {
          if (presentersScreenCubit.state.props!.isNotEmpty) {
            var presenter = presentersScreenCubit.state.props!
                .where((element) => element.isPresenter == true)
                .first;
            String presenterName = presenter.name;

            //TODO - Fix Professor ID in the proper way
            List<Rubric> currentRubric = stateRubric
                    .activity.rubrics[presentersScreenCubit.getUserId()] ??
                stateRubric.activity.rubrics.entries.first.value;

            return Scaffold(
              appBar: AppBar(
                title: Text("Presenter: $presenterName"),
              ),
              body: ListView(
                children: <Widget>[
                  ListTile(
                    title: Text(stateRubric.activity.title),
                    subtitle: ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      //TODO - Fix the index for userID to get the correct rubric
                      itemCount: currentRubric.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Card(
                            color: const Color(0xFF6D7981),
                            child: ListTile(
                              title: Text(currentRubric.elementAt(index).title,
                                  style: const TextStyle(
                                    color: Colors.white,
                                  )),
                              trailing:
                                  BlocBuilder<ActScreenCubit, ActScreenState>(
                                builder: (context, stateActivity) {
                                  return Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      for (int i = 1; i <= 5; i++)
                                        IconButton(
                                          icon: const Icon(Icons.star),
                                          color: currentRubric
                                                      .elementAt(index)
                                                      .score >=
                                                  i
                                              ? Colors.yellow
                                              : Colors.grey,
                                          onPressed: () {
                                            //ToDo: Add the logic to set the score individually
                                            context
                                                .read<RubricScreenCubit>()
                                                .setScore(
                                                    stateRubric.activity,
                                                    index,
                                                    i.toDouble(),
                                                    presenter);
                                          },
                                        ),
                                    ],
                                  );
                                },
                              ),
                            ));
                      },
                    ),
                  ),
                  const TextField(
                    enabled: true,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Open Feedback',
                    ),
                  ),
                  const TextField(
                    enabled: true,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Open Feedforward',
                    ),
                  ),
                  ElevatedButton(
                    //TODO - Fix the logic
                    onPressed: () async {
                      var userRole = await presentersScreenCubit.getUserRole();
                      if (userRole == 'teacher') {
                        presentersScreenCubit
                            .updatePresenterFeedbackByProfessor(
                                presenter, stateRubric.activity);
                        if (context.mounted) {
                          ScaffoldMessenger.of(context)
                              .showSnackBar(const SnackBar(
                            backgroundColor: Colors.green,
                            content: Text('Score Submitted Successfully!'),
                            duration: Duration(seconds: 3),
                          ));
                          Navigator.of(context).pop();
                        }
                      } else if (presentersScreenCubit
                              .checkIfFeedbackAlreadyProvidedByProfessor(
                                  presenter, stateRubric.activity) ==
                          false) {
                        if (context.mounted) {
                          ScaffoldMessenger.of(context)
                              .showSnackBar(const SnackBar(
                            backgroundColor: Colors.green,
                            content: Text(
                                'Please Wait for the Activity to complete before submitting the feedback!'),
                            duration: Duration(seconds: 3),
                          ));
                        }
                      } else {
                        presentersScreenCubit.updatePresenterActivityList(
                            presenter, stateRubric.activity);

                        if (context.mounted) {
                          ScaffoldMessenger.of(context)
                              .showSnackBar(const SnackBar(
                            backgroundColor: Colors.green,
                            content: Text('Score Submitted Successfully!'),
                            duration: Duration(seconds: 3),
                          ));
                          Navigator.of(context).pop();
                        }
                      }
                    },
                    child: const Text("Submit"),
                  ),
                ],
              ),
            );
          }
        } else {
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
                      return Card(
                          color: const Color(0xFF6D7981),
                          child: ListTile(
                            title: Text(
                                stateRubric.activity.rubrics.entries.first.value
                                    .elementAt(index)
                                    .title,
                                style: const TextStyle(
                                  color: Colors.white,
                                )),
                          ));
                    },
                  ),
                )
              ]),
              floatingActionButton:
                  homeScreenCubit.state is TeacherLoggedInState
                      ? FloatingActionButton(
                          onPressed: () {
                            //TODO - Recreate the error - The method 'addRubric' isn't defined for the type 'Function'. (Remove the ())
                            //TODO - Manual Adding Dialogue box to input the rubrics
                            context.read<ActScreenCubit>().addRubric(
                                stateRubric.activity,
                                Rubric(
                                  title: 'New Rubric from Rubric Screen',
                                  score: 0,
                                ));
                          },
                          child: const Icon(Icons.add),
                        )
                      : null);
        }
        return const FittedBox();
      });
    });
  }
}
