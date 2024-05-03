import 'package:feedback_flow/cubits/database_screen/database_screen_cubit.dart';
import 'package:feedback_flow/repository/score_repository.dart';
import 'package:feedback_flow/screens/results_screen.dart';
import 'package:flutter/material.dart';
import 'package:feedback_flow/cubits/activities_screen/activities_screen_cubit.dart';
import 'package:feedback_flow/cubits/activities_screen/activities_screen_state.dart';
import 'package:feedback_flow/models/activity.dart';
import 'package:feedback_flow/screens/rubric_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ListBuilder extends StatefulWidget {
  @override
  _ListBuilderState createState() => _ListBuilderState();
}

class _ListBuilderState extends State<ListBuilder> {
  List<Activity> activitiesList = [];
  final ScoreRepository _scoreRepository = ScoreRepository();

  @override
  void initState() {
    setActivities();
    super.initState();
  }

  void setActivities() async {
    activitiesList = await _scoreRepository.getActivities();
    setState(() {
      activitiesList;
    });
  }

  @override
  Widget build(BuildContext context) {
    DatabaseScreenCubit? databaseScreenCubit =
        BlocProvider.of<DatabaseScreenCubit>(context);

    return BlocBuilder<ActivitiesScreenCubit, ActivitiesScreenState>(
        builder: (context, stateActivity) {
      // List<Activity>? ac = stateActivity.getUpcomingActivities;

      return ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: activitiesList.length,
        itemBuilder: (BuildContext context, int index) {
          if (activitiesList![index].isDistributed == true) {
            return Card(
                color: Color.fromARGB(255, 231, 196, 191),
                child: ListTile(
                  title: Text(
                    activitiesList[index].title,
                    style: const TextStyle(
                      color: Colors.white, // Change text color to white
                    ),
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            ResultsScreen(activity: activitiesList[index]),
                      ),
                    );
                  },
                ));
          }
          return const FittedBox();
        },
      );
    });
  }
}
