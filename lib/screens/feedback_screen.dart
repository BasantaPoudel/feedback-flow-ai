import 'package:feedback_flow/cubits/act_screen/act_screen_cubit.dart';
import 'package:feedback_flow/cubits/act_screen/act_screen_state.dart';
import 'package:feedback_flow/cubits/presenters_screen/presenters_screen_cubit.dart';
import 'package:feedback_flow/cubits/rubric_screen/rubric_screen_cubit.dart';
import 'package:feedback_flow/cubits/rubric_screen/rubric_screen_state.dart';
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

  @override
  void initState() {
    super.initState();
    userrepo = UserRepository();
  }

  @override
  Widget build(BuildContext context) {
    PresenterScreenCubit? presentersScreenCubit =
        BlocProvider.of<PresenterScreenCubit>(context);
    return BlocBuilder<RubricScreenCubit, RubricScreenState>(
        builder: (context, stateRubric) {
      return BlocBuilder<ActScreenCubit, ActScreenState>(
          builder: (context, stateActivity) {
        if (stateActivity is ActivityStarted && stateRubric.activity != null) {
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
                  Container(
                    padding: const EdgeInsets.all(10),
                    child: const TextField(
                      enabled: true,
                      decoration: InputDecoration(
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
                    child: const TextField(
                      enabled: true,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Open Feedforward',
                      ),
                    ),
                  ),
                  ElevatedButton(
                    //TODO - Fix the logic
                    onPressed: () async {
                      var userRole = await presentersScreenCubit.getUserRole();
                      if (userRole == 'professor') {
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
                          // Navigator.of(context).pop();
                        }
                      } else if (presentersScreenCubit
                              .checkIfFeedbackAlreadyProvidedByProfessor(
                                  presenter, stateRubric.activity) ==
                          false) {
                        if (context.mounted) {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            backgroundColor: Colors.green,
                            content: Container(
                              padding: const EdgeInsets.all(10),
                              child: Text(
                                'Please Wait for the Activity to complete before submitting the feedback!',
                                style: Theme.of(context).textTheme.bodySmall,
                              ),
                            ),
                            duration: const Duration(seconds: 3),
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
                          // Navigator.of(context).pop();
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
                          Image.asset('assets/image/welcome_transparent.png'),
                          Text(
                            'Please wait for the activity to start before you can provide peer feedback',
                            style: Theme.of(context).textTheme.displaySmall,
                          ),
                        ]),
                  )));
        }
        return const FittedBox();
      });
    });
  }
}
