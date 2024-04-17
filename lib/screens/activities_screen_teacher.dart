import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:feedback_flow/cubits/activities_screen/activities_screen_cubit.dart';
import 'package:feedback_flow/cubits/activities_screen/activities_screen_state.dart';
import 'package:feedback_flow/cubits/database_screen/database_screen_cubit.dart';
import 'package:feedback_flow/cubits/database_screen/database_screen_state.dart';
import 'package:feedback_flow/models/activity.dart';
import 'package:feedback_flow/models/rubric.dart';
import 'package:feedback_flow/screens/rubric_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ActivitiesTeacherScreen extends StatefulWidget {
  const ActivitiesTeacherScreen({Key? key}) : super(key: key);

  @override
  _ActivitiesTeacherScreenState createState() =>
      _ActivitiesTeacherScreenState();
}

class _ActivitiesTeacherScreenState extends State<ActivitiesTeacherScreen> {
  final _controllerTitle = TextEditingController();
  final _controllerRubric = TextEditingController();

  final Stream<QuerySnapshot> _activitiesStream =
      FirebaseFirestore.instance.collection('activities').snapshots();

  @override
  Widget build(BuildContext context) {
    final _controllerTitle = TextEditingController();
    final _controllerRubric = TextEditingController();

    DatabaseScreenCubit? databaseScreenCubit =
        BlocProvider.of<DatabaseScreenCubit>(context);

    ActivitiesScreenCubit? activitiesScreenCubit =
        BlocProvider.of<ActivitiesScreenCubit>(context);

    return BlocListener<ActivitiesScreenCubit, ActivitiesScreenState>(
        listener: (context, state) {
      if (state is ActivityErrorLoading) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('Failed to load items')));
      }
    }, child: BlocBuilder<ActivitiesScreenCubit, ActivitiesScreenState>(
            builder: (context, stateActivity) {
      // List<Activity> activitiesList = stateActivity.getUpcomingActivities;
      List<Activity>? pastActivities = stateActivity.getPastActivities;
      return Scaffold(
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) {
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
                          ));
                          Navigator.of(context).pop();
                        },
                        child: const Text('Add activity'),
                      ),
                    ],
                  );
                },
              );
            },
            child: const Icon(Icons.add),
          ),
          body: ListView(
            children: <Widget>[
              ListTile(
                title: const Text('Past In Class Activities'),
                subtitle: ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),

                  //BM - https://stackoverflow.com/questions/64278595/null-check-operator-used-on-a-null-value
                  itemCount: pastActivities?.length ?? 0,
                  itemBuilder: (BuildContext context, int index) {
                    if (pastActivities?[index].isDistributed == true) {
                      return Card(
                          color: const Color(0xFF6D7981),
                          child: ListTile(
                            title: Text(
                              pastActivities![index].title,
                              style: const TextStyle(
                                color:
                                    Colors.white, // Change text color to white
                              ),
                            ),
                            onTap: () {
                              Navigator.push(
                                context,
                                //TODO - Correct the logic to display ScoreScreen or RubricScreen based on the activity status
                                MaterialPageRoute(
                                  builder: (context) => RubricScreen(
                                      activity: pastActivities![index]),
                                ),
                              );
                              // Navigator.push(
                              //   context,
                              //   MaterialPageRoute(
                              //     builder: (context) => RubricScreen(
                              //       texts: activitiesList[index]
                              //           .rubrics
                              //           .map((rubric) => rubric.name)
                              //           .toList(),
                              //     ),
                              //   ),
                              // );
                              // handle your item click here
                            },
                          ));

                      // handle your item click here
                    }
                    return const FittedBox();
                    // handle your item click here
                  },
                ),
              ),
              BlocBuilder<ActivitiesScreenCubit, ActivitiesScreenState>(
                  builder: (context, stateActivity) {
                List<Activity> activitiesList =
                    stateActivity.getUpcomingActivities;
                return ListTile(
                  title: const Text('Upcoming In Class Activities'),
                  subtitle: ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: activitiesList
                          .length, // replace with your actual list length
                      itemBuilder: (BuildContext context, int index) {
                        if (activitiesList[index].isDistributed == false) {
                          return Card(
                              color: const Color(0xFF6D7981),
                              child: ListTile(
                                  title: Text(
                                    activitiesList[index].title,
                                    style: const TextStyle(
                                      color: Colors
                                          .white, // Change text color to white
                                    ),
                                  ),
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      //TODO - Correct the logic to display ScoreScreen or RubricScreen based on the activity status
                                      MaterialPageRoute(
                                        builder: (context) => RubricScreen(
                                            activity: activitiesList[index]),
                                      ),
                                    );
                                    // Navigator.push(
                                    //   context,
                                    //   MaterialPageRoute(
                                    //     builder: (context) => RubricScreen(
                                    //       texts: activitiesList[index]
                                    //           .rubrics
                                    //           .map((rubric) => rubric.name)
                                    //           .toList(),
                                    //     ),
                                    //   ),
                                    // );
                                    // handle your item click here
                                  },
                                  trailing: BlocBuilder<DatabaseScreenCubit,
                                          DatabaseScreenState>(
                                      builder: (context, state) {
                                    if (state is PresenterState) {
                                      return BlocBuilder<ActivitiesScreenCubit,
                                              ActivitiesScreenState>(
                                          builder: (context, stateActivity) {
                                        if (activitiesList[index].isStarted ==
                                            false) {
                                          return FittedBox(
                                            child: Row(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                ElevatedButton(
                                                    onPressed: () {
                                                      activitiesScreenCubit
                                                          .startActivity(
                                                              activitiesList,
                                                              index);
                                                    },
                                                    child: const Text('Start'))
                                              ],
                                            ),
                                          );
                                        } else if (stateActivity
                                                is ActivityStarted &&
                                            activitiesList[index].isStarted ==
                                                true) {
                                          return FittedBox(
                                            child: Row(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                ElevatedButton(
                                                    onPressed: () {
                                                      activitiesScreenCubit
                                                          .endActivity(
                                                              activitiesList,
                                                              index);
                                                    },
                                                    child: const Text('End')),
                                              ],
                                            ),
                                          );
                                        } else if (stateActivity
                                                is ActivityEnded &&
                                            activitiesList[index].isCompleted ==
                                                true) {
                                          return FittedBox(
                                            child: Row(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                ElevatedButton(
                                                    onPressed: () {
                                                      activitiesScreenCubit
                                                          .distributeResults(
                                                              activitiesList,
                                                              index);
                                                    },
                                                    child: const Text(
                                                        'Distribute Results')),
                                              ],
                                            ),
                                          );
                                        } else {
                                          return const FittedBox();
                                        }
                                      });
                                      // return const FittedBox();
                                    } else {
                                      return const FittedBox();
                                    }
                                  })));
                        }
                        return const FittedBox(
                            child: Text("isDistributed is true"));

                        // return null;
                      }),
                );
              }),
            ],
          ));
      return const FittedBox();
    }));
    return const FittedBox();
  }
}
