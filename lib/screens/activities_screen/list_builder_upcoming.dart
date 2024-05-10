import 'package:feedback_flow/cubits/act_screen/act_screen_cubit.dart';
import 'package:feedback_flow/cubits/act_screen/act_screen_state.dart';
import 'package:feedback_flow/cubits/presenters_screen/presenters_screen_cubit.dart';
import 'package:feedback_flow/cubits/presenters_screen/presenters_screen_state.dart';
import 'package:feedback_flow/cubits/rubric_screen/rubric_screen_cubit.dart';
import 'package:feedback_flow/screens/activities_screen/upcoming_trailing.dart';
import 'package:feedback_flow/screens/rubric_screen.dart';
import 'package:flutter/material.dart';

import 'package:feedback_flow/models/activity.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ListBuilderUpcoming extends StatefulWidget {
  const ListBuilderUpcoming({super.key, required this.activitiesList});

  @override
  _ListBuilderUpcomingState createState() => _ListBuilderUpcomingState();
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

    // final ScrollController scrollController = ScrollController();
    return BlocBuilder<ActScreenCubit, ActScreenState>(
        builder: (context, stateActivity) {
      List<Activity>? activitiesList = widget.activitiesList;
      if (databaseScreenCubit.state is PresenterState &&
          databaseScreenCubit.state.props!.isNotEmpty) {
        var presenter = databaseScreenCubit.state.props!
            .where((element) => element.isPresenter == true)
            .first;
        return Container(
            // height: MediaQuery.of(context).size.height * 0.2,
            width: MediaQuery.of(context).size.width * 0.8,
            padding: const EdgeInsets.all(2),
            child: ListTile(
                subtitle: ListView.builder(
              shrinkWrap: true,
              itemCount: activitiesList.length ?? 0,
              itemBuilder: (BuildContext context, int index) {
                if (activitiesList[index].isDistributed == false) {
                  return Card(
                      color: activitiesList[index].isStarted
                          ? Colors.green
                          : const Color(0xFF6D7981),
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
            )));
      }
      return const FittedBox();
    });
  }
}
