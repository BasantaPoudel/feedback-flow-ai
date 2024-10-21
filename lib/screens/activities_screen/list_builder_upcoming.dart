import 'package:feedback_flow/cubits/act_screen/act_screen_cubit.dart';
import 'package:feedback_flow/cubits/act_screen/act_screen_state.dart';
import 'package:feedback_flow/cubits/home_screen/home_screen_cubit.dart';
import 'package:feedback_flow/cubits/home_screen/home_screen_state.dart';
import 'package:feedback_flow/cubits/presenters_screen/presenters_screen_cubit.dart';
import 'package:feedback_flow/cubits/presenters_screen/presenters_screen_state.dart';
import 'package:feedback_flow/cubits/rubric_screen/rubric_screen_cubit.dart';
import 'package:feedback_flow/screens/activities_screen/edit_activity.dart';
import 'package:feedback_flow/screens/activities_screen/upcoming_trailing.dart';
import 'package:feedback_flow/screens/rubric_screen.dart';
import 'package:flutter/material.dart';

import 'package:feedback_flow/models/activity.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class ListBuilderUpcoming extends StatefulWidget {
  const ListBuilderUpcoming({super.key, required this.activitiesList});

  @override
  State<ListBuilderUpcoming> createState() => _ListBuilderUpcomingState();
  final List<Activity> activitiesList;
}

class _ListBuilderUpcomingState extends State<ListBuilderUpcoming> {
  @override
  void initState() {
    super.initState();
  }

  void setActivities() async {
    setState(() {
      widget.activitiesList;
    });
  }

  @override
  Widget build(BuildContext context) {
    PresenterScreenCubit? databaseScreenCubit =
        BlocProvider.of<PresenterScreenCubit>(context);

    RubricScreenCubit? rubricScreenCubit =
        BlocProvider.of<RubricScreenCubit>(context);

    HomeScreenCubit? homeScreenCubit =
        BlocProvider.of<HomeScreenCubit>(context);

    final ScrollController scrollController = ScrollController();
    return BlocBuilder<ActScreenCubit, ActScreenState>(
        builder: (context, stateActivity) {
      List<Activity>? activitiesList = widget.activitiesList;
      if (databaseScreenCubit.state is PresenterState &&
          databaseScreenCubit.state.props!.isNotEmpty) {
        var presenter = databaseScreenCubit.state.props!
            .where((element) => element.isPresenter == true)
            .first;

        //Presenter Selected -  Disable Slider
        return Scrollbar(
            thumbVisibility: true,
            controller: scrollController,
            thickness: 5,
            radius: const Radius.circular(50),
            child: ListView.builder(
              padding: const EdgeInsets.only(right: 10),
              controller: scrollController,
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              itemCount: activitiesList.length,
              itemBuilder: (BuildContext context, int index) {
                if (activitiesList[index].isDistributed == false) {
                  return Card(
                      color: activitiesList[index].isStarted
                          ? const Color.fromRGBO(210, 236, 199, 1)
                          : const Color.fromRGBO(146, 151, 196, 1),
                      child: ListTile(
                          title: Text(
                            activitiesList[index].title,
                            style: const TextStyle(
                              color: Colors.black, // Change text color to white
                            ),
                          ),
                          onTap: () {
                            rubricScreenCubit.addActivityToRubricState(
                                widget.activitiesList[index], presenter);
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => RubricScreen(
                                    activity: activitiesList[index]),
                              ),
                            );
                          },
                          trailing: UpcomingTrailing(
                              activitiesList: activitiesList, index: index)));
                }
                return const FittedBox();
              },
            ));
      } else {
        //Presenter Not Selected -  List Without Upcoming Trailing but Slider can work
        return Scrollbar(
            thumbVisibility: true,
            controller: scrollController,
            thickness: 5,
            radius: const Radius.circular(50),
            child: ListView.builder(
              padding: const EdgeInsets.only(right: 10),
              controller: scrollController,
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              itemCount: activitiesList.length,
              itemBuilder: (BuildContext context, int index) {
                if (activitiesList[index].isDistributed == false) {
                  return Slidable(
                      startActionPane: homeScreenCubit.state
                              is ProfessorLoggedInState
                          ? ActionPane(
                              motion: const StretchMotion(),
                              children: [
                                  SlidableAction(
                                    borderRadius: BorderRadius.circular(10),
                                    backgroundColor: Colors.blue,
                                    icon: Icons.copy,
                                    onPressed: (context) => {
                                      BlocProvider.of<ActScreenCubit>(context)
                                          .duplicateActivity(
                                              activitiesList[index])
                                    },
                                  )
                                ])
                          : null,
                      endActionPane: homeScreenCubit.state
                              is ProfessorLoggedInState
                          ? ActionPane(motion: const ScrollMotion(), children: [
                              SlidableAction(
                                  borderRadius: BorderRadius.circular(10),
                                  icon: Icons.edit,
                                  backgroundColor: Colors.blue,
                                  onPressed: (context) {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            EditActivity.withActivity(
                                                activitiesList[index]),
                                      ),
                                    );
                                  }),
                              SlidableAction(
                                borderRadius: BorderRadius.circular(10),
                                icon: Icons.delete,
                                backgroundColor: Colors.red,
                                onPressed: (context) => {
                                  BlocProvider.of<ActScreenCubit>(context)
                                      .deleteActivity(activitiesList[index])
                                },
                              )
                            ])
                          : null,
                      child: Card(
                          color: activitiesList[index].isStarted
                              ? const Color.fromRGBO(210, 236, 199, 1)
                              : const Color.fromRGBO(146, 151, 196, 1),
                          child: ListTile(
                            title: Text(
                              activitiesList[index].title,
                              style: const TextStyle(
                                color:
                                    Colors.black, // Change text color to white
                              ),
                            ),
                            onTap: () {
                              rubricScreenCubit
                                  .loadRubric(widget.activitiesList[index]);
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => RubricScreen(
                                      activity: activitiesList[index]),
                                ),
                              );
                            },
                          )));
                }
                return const FittedBox();
              },
            ));
      }
    });
  }
}
