import 'package:feedback_flow/cubits/act_screen/act_screen_cubit.dart';
import 'package:feedback_flow/cubits/act_screen/act_screen_state.dart';
import 'package:feedback_flow/cubits/presenters_screen/presenters_screen_cubit.dart';
import 'package:feedback_flow/cubits/presenters_screen/presenters_screen_state.dart';
import 'package:feedback_flow/cubits/rubric_screen/rubric_screen_cubit.dart';
import 'package:feedback_flow/cubits/rubric_screen/rubric_screen_state.dart';
import 'package:feedback_flow/main.dart';
import 'package:feedback_flow/models/activity.dart';
import 'package:feedback_flow/models/rubric.dart';
import 'package:feedback_flow/repository/user_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FeedbackScreen extends StatefulWidget {
  const FeedbackScreen({super.key});

  @override
  State<FeedbackScreen> createState() => _FeedbackScreenState();
}

class _FeedbackScreenState extends State<FeedbackScreen> {
  late UserRepository userrepo;

  final _controllerFeedback = TextEditingController();
  final _controllerFeedForward = TextEditingController();
  @override
  void initState() {
    super.initState();
    userrepo = UserRepository();
  }

  @override
  void dispose() {
    _controllerFeedback.dispose();
    _controllerFeedForward.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    PresenterScreenCubit? presentersScreenCubit =
        BlocProvider.of<PresenterScreenCubit>(context);

    return BlocBuilder<PresenterScreenCubit, PresenterScreenState>(
        builder: (context, statePresenter) {
      return BlocBuilder<RubricScreenCubit, RubricScreenState>(
          builder: (context, stateRubric) {
        return BlocBuilder<ActScreenCubit, ActScreenState>(
            builder: (context, stateActivity) {
          if (stateActivity is ActivityStarted) {
            //TODO - Retry solving with the dispose method
            Activity startedActivity = stateActivity.activity;
            if (stateRubric is RubricScreenInitial ||
                stateRubric.activity!.title != startedActivity.title) {
              context.read<RubricScreenCubit>().loadRubric(startedActivity);
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
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
                                title:
                                    Text(currentRubric.elementAt(index).title,
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
                    Container(
                      padding: const EdgeInsets.all(10),
                      child: TextField(
                        controller: _controllerFeedback,
                        enabled: true,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Open Feedback',
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Container(
                      padding: const EdgeInsets.all(10),
                      child: TextField(
                        controller: _controllerFeedForward,
                        enabled: true,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Open Feedforward',
                        ),
                      ),
                    ),
                    ElevatedButton(
                      //TODO - Fix the logic
                      onPressed: () async {
                        var userRole =
                            await presentersScreenCubit.getUserRole();
                        if (userRole == 'professor') {
                          stateRubric.activity.openFeedback = {
                            "professor": _controllerFeedback.text
                          };
                          stateRubric.activity.openFeedForward = {
                            "professor": _controllerFeedForward.text
                          };

                          try {
                            await presentersScreenCubit
                                .updatePresenterFeedbackByProfessor(
                                    presenter, stateRubric.activity);
                            // context
                            //     .read<RubricScreenCubit>()
                            //     .clearRubricState();
                            if (context.mounted) {
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: const Text('Feedback'),
                                    content: const Text(
                                        'Score Submitted Successfully! You can resubmit the feedback if you wish to change anything.'),
                                    actions: <Widget>[
                                      TextButton(
                                        child: const Text('OK'),
                                        onPressed: () {
                                          _controllerFeedback.clear();
                                          _controllerFeedForward.clear();
                                          Navigator.of(context)
                                              .pop(); // Close the dialog
                                        },
                                      ),
                                    ],
                                  );
                                },
                              );
                              // ScaffoldMessenger.of(context)
                              //     .showSnackBar(const SnackBar(
                              //   backgroundColor: Colors.green,
                              //   content: Text('Score Submitted Successfully!'),
                              //   duration: Duration(seconds: 3),
                              // ));

                              // Navigator.of(context).pop();
                            }
                            RestartWidget.restartApp(context);
                          } catch (e) {
                            ScaffoldMessenger.of(context)
                                .showSnackBar(const SnackBar(
                              backgroundColor: Colors.red,
                              content: Text('Score Submission Failed!'),
                              duration: Duration(seconds: 3),
                            ));
                          }
                        } else if (presentersScreenCubit
                                .checkIfFeedbackAlreadyProvidedByProfessor(
                                    presenter, stateRubric.activity) ==
                            false) {
                          if (context.mounted) {
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              backgroundColor: Colors.red,
                              content: Container(
                                padding: const EdgeInsets.all(10),
                                child: Text(
                                  'Please wait until the end of the activity before submitting the feedback!',
                                  style: Theme.of(context).textTheme.bodySmall,
                                ),
                              ),
                              duration: const Duration(seconds: 3),
                            ));
                          }
                        } else {
                          stateRubric.activity.openFeedback = {
                            presentersScreenCubit.getUserId():
                                _controllerFeedback.text
                          };

                          stateRubric.activity.openFeedForward = {
                            presentersScreenCubit.getUserId():
                                _controllerFeedForward.text
                          };

                          try {
                            await presentersScreenCubit
                                .updatePresenterActivityList(
                                    presenter, stateRubric.activity);
                            // context
                            //     .read<RubricScreenCubit>()
                            //     .clearRubricState();
                            // RestartWidget.restartApp(context);
                          } catch (e) {
                            ScaffoldMessenger.of(context)
                                .showSnackBar(const SnackBar(
                              backgroundColor: Colors.red,
                              content: Text('Score Submission Failed!'),
                              duration: Duration(seconds: 3),
                            ));
                          }

                          if (context.mounted) {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: const Text('Feedback'),
                                  content: const Text(
                                      'Score Submitted Successfully! You can resubmit the feedback if you wish to change anything.'),
                                  actions: <Widget>[
                                    TextButton(
                                      child: const Text('OK'),
                                      onPressed: () {
                                        Navigator.of(context)
                                            .pop(); // Close the dialog
                                        RestartWidget.restartApp(context);
                                      },
                                    ),
                                  ],
                                );
                              },
                            );
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
                            Expanded(
                              child: Image.asset(
                                'assets/image/welcome_transparent.png',
                              ),
                            ),
                            Container(
                              margin:
                                  const EdgeInsets.only(top: 20, bottom: 30),
                              padding: const EdgeInsets.all(10),
                              child: Text(
                                'You can provide peer feedback only when the in-class activity is started by the professor and the presenter. Please wait ...',
                                style: Theme.of(context).textTheme.titleLarge,
                              ),
                            ),
                          ]),
                    )));
          }
          return const FittedBox();
        });
      });
    });
  }
}
