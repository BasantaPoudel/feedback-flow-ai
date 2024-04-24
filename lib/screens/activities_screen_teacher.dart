import 'package:feedback_flow/cubits/activities_screen/activities_screen_cubit.dart';
import 'package:feedback_flow/cubits/activities_screen/activities_screen_state.dart';
import 'package:feedback_flow/cubits/database_screen/database_screen_cubit.dart';
import 'package:feedback_flow/cubits/database_screen/database_screen_state.dart';
import 'package:feedback_flow/models/activity.dart';
import 'package:feedback_flow/screens/activities_screen/add_activity.dart';
import 'package:feedback_flow/screens/activities_screen/list_builder.dart';
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
  @override
  Widget build(BuildContext context) {
    ActivitiesScreenCubit? activitiesScreenCubit =
        BlocProvider.of<ActivitiesScreenCubit>(context);

    //Adding BlocProvider here will make it accessible to the childwidget
    return BlocListener<ActivitiesScreenCubit, ActivitiesScreenState>(
        listener: (context, state) {
      if (state is ActivityErrorLoading) {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Failed to load items')));
      }
    }, child: BlocBuilder<ActivitiesScreenCubit, ActivitiesScreenState>(
            builder: (context, stateActivity) {
      return Scaffold(
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) {
                  return AddActivity();
                },
              );
            },
            child: const Icon(Icons.add),
          ),
          body: ListView(
            children: <Widget>[
              ListTile(
                title: const Text('Past In Class Activities'),
                subtitle: ListBuilder(),
              ),
              BlocBuilder<ActivitiesScreenCubit, ActivitiesScreenState>(
                  builder: (context, stateActivity) {
                List<Activity>? activitiesList =
                    stateActivity.getUpcomingActivities;
                return ListTile(
                  title: const Text('Upcoming In Class Activities'),
                  subtitle: ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: activitiesList?.length ?? 0,
                      itemBuilder: (BuildContext context, int index) {
                        if (activitiesList![index].isDistributed == false) {
                          return Card(
                              color: activitiesList[index].isStarted
                                  ? Colors.green
                                  : const Color(0xFF6D7981),
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
                                      MaterialPageRoute(
                                        builder: (context) => RubricScreen(
                                            activity: activitiesList[index]),
                                      ),
                                    );
                                  },
                                  trailing: BlocBuilder<DatabaseScreenCubit,
                                          DatabaseScreenState>(
                                      builder: (context, state) {
                                    if (state is PresenterState) {
                                      return BlocBuilder<ActivitiesScreenCubit,
                                              ActivitiesScreenState>(
                                          builder: (context, stateActivity) {
                                        if (stateActivity
                                            is ActivityLoadedState) {
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
                                                  child: const Text('End'),
                                                )
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
                        return const FittedBox(); // return null;
                      }),
                );
              }),
            ],
          ));
    }));
  }
}
