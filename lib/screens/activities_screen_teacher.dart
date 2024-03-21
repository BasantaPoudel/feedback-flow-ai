import 'dart:math';

import 'package:feedback_flow/cubits/activities_screen/activities_screen_cubit.dart';
import 'package:feedback_flow/cubits/activities_screen/activities_screen_state.dart';
import 'package:feedback_flow/cubits/database_screen/database_screen_cubit.dart';
import 'package:feedback_flow/cubits/database_screen/database_screen_state.dart';
import 'package:feedback_flow/screens/rubric_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ActivitiesTeacherScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    DatabaseScreenCubit? _databaseScreenCubit =
        BlocProvider.of<DatabaseScreenCubit>(context);

    ActivitiesScreenCubit? _activitiesScreenCubit =
        BlocProvider.of<ActivitiesScreenCubit>(context);

    return BlocBuilder<ActivitiesScreenCubit, ActivitiesScreenState>(
        builder: (context, stateActivity) {
      final activitiesList = stateActivity.getActivities;
      return Scaffold(
          floatingActionButton: FloatingActionButton(
            onPressed: () {},
            child: const Icon(Icons.add),
          ),
          body: ListView(
            children: <Widget>[
              ListTile(
                title: Text('Past In Class Activities'),
                subtitle: ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: activitiesList
                      .length, // replace with your actual list length
                  itemBuilder: (BuildContext context, int index) {
                    if (activitiesList[index].isCompleted == true) {
                      return Card(
                          color: Color(0xFF6D7981),
                          child: ListTile(
                            title: Text(
                              activitiesList[index].title,
                              style: TextStyle(
                                color:
                                    Colors.white, // Change text color to white
                              ),
                            ),
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => RubricScreen(
                                    texts: activitiesList[index]
                                        .rubrics
                                        .map((rubric) => rubric.name)
                                        .toList(),
                                  ),
                                ),
                              );
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
                final activitiesList = stateActivity.getActivities;
                return ListTile(
                  title: Text('Upcoming In Class Activities'),
                  subtitle: ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: activitiesList
                          .length, // replace with your actual list length
                      itemBuilder: (BuildContext context, int index) {
                        if (activitiesList[index].isDistributed == false) {
                          return Card(
                              color: Color(0xFF6D7981),
                              child: ListTile(
                                  title: Text(
                                    activitiesList[index].title,
                                    style: TextStyle(
                                      color: Colors
                                          .white, // Change text color to white
                                    ),
                                  ),
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => RubricScreen(
                                          texts: activitiesList[index]
                                              .rubrics
                                              .map((rubric) => rubric.name)
                                              .toList(),
                                        ),
                                      ),
                                    );
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
                                                      _activitiesScreenCubit
                                                          .startActivity(
                                                              activitiesList,
                                                              index);
                                                    },
                                                    child: Text('Start'))
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
                                                      _activitiesScreenCubit
                                                          .endActivity(
                                                              activitiesList,
                                                              index);
                                                    },
                                                    child: Text('End')),
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
                                                      _activitiesScreenCubit
                                                          .distributeResults(
                                                              activitiesList,
                                                              index);
                                                    },
                                                    child: Text(
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
                      }),
                );
              }),
            ],
          ));
      return const FittedBox();
    });
    return const FittedBox();
  }
}
