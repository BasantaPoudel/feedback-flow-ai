import 'package:feedback_flow/cubits/activities_screen/activities_screen_cubit.dart';
import 'package:feedback_flow/cubits/activities_screen/activities_screen_state.dart';
import 'package:feedback_flow/cubits/presenters_screen/presenters_screen_cubit.dart';
import 'package:feedback_flow/cubits/presenters_screen/presenters_screen_state.dart';
import 'package:feedback_flow/cubits/rubric_screen/rubric_screen_cubit.dart';
import 'package:feedback_flow/cubits/rubric_screen/rubric_screen_state.dart';
import 'package:feedback_flow/models/activity.dart';
import 'package:feedback_flow/models/rubric.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RubricScreen extends StatefulWidget {
  const RubricScreen({super.key, required this.activity});

  @override
  _RubricScreenState createState() => _RubricScreenState();
  final Activity activity;
}

class _RubricScreenState extends State<RubricScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    PresenterScreenCubit? databaseScreenCubit =
        BlocProvider.of<PresenterScreenCubit>(context);

    ActivitiesScreenCubit? activitiesScreenCubit =
        BlocProvider.of<ActivitiesScreenCubit>(context);

    RubricScreenCubit? rubricScreenCubit =
        BlocProvider.of<RubricScreenCubit>(context);

    return BlocBuilder<RubricScreenCubit, RubricScreenState>(
        builder: (context, stateRubric) {
      if (stateRubric is RubricScreenInitial) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      }
      return BlocProvider(
          create: (context) => PresenterScreenCubit()..subscribeToData(),
          child: BlocBuilder<ActivitiesScreenCubit, ActivitiesScreenState>(
              builder: (context, stateActivity) {
            if (stateActivity is ActivityStarted &&
                stateRubric.activity.isStarted &&
                databaseScreenCubit.state is PresenterState) {
              if (databaseScreenCubit.state.props!.isNotEmpty) {
                var presenter = databaseScreenCubit.state.props!
                    .where((element) => element.isPresenter == true)
                    .first;
                String presenterName = presenter.name;
                List<Rubric> currentRubric = stateRubric
                        .activity.rubrics[databaseScreenCubit.getUserId()] ??
                    stateRubric
                        .activity.rubrics["CN5Njs6mhGOtuGyxCAZlsm1Owhg1"];

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
                                      Text(currentRubric.elementAt(index).name,
                                          style: const TextStyle(
                                            color: Colors.white,
                                          )),
                                  trailing: BlocBuilder<ActivitiesScreenCubit,
                                      ActivitiesScreenState>(
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
                                                rubricScreenCubit.setScore(
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
                        enabled: false,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Open Feedback',
                        ),
                      ),
                      const TextField(
                        enabled: false,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Open Feedforward',
                        ),
                      ),
                      ElevatedButton(
                        //TODO - Fix the logic
                        onPressed: () {
                          databaseScreenCubit.updatePresenterActivityList(
                              presenter, stateRubric.activity);
                          ScaffoldMessenger.of(context)
                              .showSnackBar(const SnackBar(
                            backgroundColor: Colors.green,
                            content: Text('Score Submitted Successfully!'),
                            duration: Duration(seconds: 3),
                          ));
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
                        itemCount: stateRubric.activity
                            .rubrics["CN5Njs6mhGOtuGyxCAZlsm1Owhg1"]!.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Card(
                              color: const Color(0xFF6D7981),
                              child: ListTile(
                                title: Text(
                                    stateRubric
                                        .activity
                                        .rubrics[
                                            "CN5Njs6mhGOtuGyxCAZlsm1Owhg1"]!
                                        .elementAt(index)
                                        .name,
                                    style: const TextStyle(
                                      color: Colors.white,
                                    )),
                              ));
                        },
                      ),
                    )
                  ]),
                  floatingActionButton: FloatingActionButton(
                    onPressed: () {
                      activitiesScreenCubit.addRubric(
                          stateRubric.activity,
                          Rubric(
                            name: 'New Rubric from Rubric Screen',
                            score: 0,
                          ));
                    },
                    child: const Icon(Icons.add),
                  ));
            }
            return const FittedBox();
          }));
    });
  }
}
