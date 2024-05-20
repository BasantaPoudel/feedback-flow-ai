import 'package:feedback_flow/cubits/act_screen/act_screen_cubit.dart';
import 'package:feedback_flow/cubits/act_screen/act_screen_state.dart';
import 'package:feedback_flow/cubits/home_screen/home_screen_cubit.dart';
import 'package:feedback_flow/cubits/home_screen/home_screen_state.dart';
import 'package:feedback_flow/cubits/presenters_screen/presenters_screen_cubit.dart';
import 'package:feedback_flow/cubits/presenters_screen/presenters_screen_state.dart';
import 'package:feedback_flow/cubits/rubric_screen/rubric_screen_cubit.dart';
import 'package:feedback_flow/models/activity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UpcomingTrailing extends StatefulWidget {
  @override
  _UpcomingTrailingState createState() => _UpcomingTrailingState();
  final List<Activity> activitiesList;
  final int index;

  const UpcomingTrailing(
      {Key? key, required this.activitiesList, required this.index})
      : super(key: key);
}

class _UpcomingTrailingState extends State<UpcomingTrailing> {
  @override
  Widget build(BuildContext context) {
    ActScreenCubit? activitiesScreenCubit =
        BlocProvider.of<ActScreenCubit>(context);

    PresenterScreenCubit? databaseScreenCubit =
        BlocProvider.of<PresenterScreenCubit>(context);

    HomeScreenCubit? homeScreenCubit =
        BlocProvider.of<HomeScreenCubit>(context);

    RubricScreenCubit? rubricScreenCubit =
        BlocProvider.of<RubricScreenCubit>(context);

    return BlocBuilder<PresenterScreenCubit, PresenterScreenState>(
        builder: (context, state) {
      if (state is PresenterState &&
          homeScreenCubit.state is TeacherLoggedInState) {
        if (databaseScreenCubit.state.props!.isNotEmpty) {
          var presenter = databaseScreenCubit.state.props!
              .where((element) => element.isPresenter == true)
              .first;

          return BlocBuilder<ActScreenCubit, ActScreenState>(
              builder: (context, stateActivity) {
            if (stateActivity is ActivityLoadedState) {
              return FittedBox(
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    ElevatedButton(
                        onPressed: () {
                          rubricScreenCubit.addActivityByProfessor(
                              widget.activitiesList[widget.index], presenter);

                          activitiesScreenCubit.startActivity(
                              widget.activitiesList, widget.index);
                        },
                        child: const Text('Start'))
                  ],
                ),
              );
            } else if (stateActivity is ActivityStarted &&
                widget.activitiesList[widget.index].isStarted == true) {
              return FittedBox(
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        activitiesScreenCubit.endActivity(
                            widget.activitiesList, widget.index);
                      },
                      child: const Text('End'),
                    )
                  ],
                ),
              );
            } else if (stateActivity is ActivityEnded &&
                widget.activitiesList[widget.index].isCompleted == true) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Expanded(
                      child: ElevatedButton(
                          onPressed: () {
                            rubricScreenCubit.addActivityByProfessor(
                                widget.activitiesList[widget.index], presenter);

                            activitiesScreenCubit.startActivity(
                                widget.activitiesList, widget.index);
                          },
                          child: const Text('Start Again'))),
                  const SizedBox(
                    height: 4,
                  ),
                  Expanded(
                      child: ElevatedButton(
                          onPressed: () {
                            activitiesScreenCubit.distributeResults(
                                widget.activitiesList, widget.index);
                          },
                          child: const Text('Distribute Results'))),
                ],
              );
            } else {
              return const FittedBox();
            }
          });
        } else {
          return const FittedBox();
        }
      }
      return const FittedBox();
    });
  }
}
