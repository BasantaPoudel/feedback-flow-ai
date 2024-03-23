import 'package:feedback_flow/cubits/activities_screen/activities_screen_cubit.dart';
import 'package:feedback_flow/cubits/activities_screen/activities_screen_state.dart';
import 'package:feedback_flow/models/activity.dart';
import 'package:feedback_flow/repository/score_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ScoreScreen extends StatefulWidget {
  const ScoreScreen({super.key});

  @override
  _ScoreScreenState createState() => _ScoreScreenState();
}

class _ScoreScreenState extends State<ScoreScreen> {
  final ScoreRepository _scoreRepository = ScoreRepository();
  int _score2 = 0;
  int _score1 = 0;
  void _sendScoreToFirebase(score1, score2) {
    // Send the score to Firebase database
    _scoreRepository.sendScoreToFirebase(score1, score2);
  }

  @override
  Widget build(BuildContext context) {
    // ScoreCubit? scoreCubit = BlocProvider.of<ScoreCubit>(context);
    // DatabaseScreenCubit? databaseScreenCubit =
    //     BlocProvider.of<DatabaseScreenCubit>(context);

    ActivitiesScreenCubit? activitiesScreenCubit =
        BlocProvider.of<ActivitiesScreenCubit>(context);
    // BlocBuilder<DatabaseScreenCubit, DatabaseScreenState>(
    //     builder: (context, state) {
    //   if (state is PresenterState) {
    //     return ListTile(
    //       title: Text(state.props![0].toString()),
    //     );
    //   }
    //   return FittedBox();
    // });

    return BlocBuilder<ActivitiesScreenCubit, ActivitiesScreenState>(
        builder: (context, stateActivity) {
      List<Activity> activitiesList = stateActivity.getUpcomingActivities;
      if (stateActivity is ActivityStarted) {
        return Scaffold(
            body: ListView(children: <Widget>[
          ListTile(
            title: Text(activitiesList[0].title),
            subtitle: ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: activitiesList[0].rubrics.length,
              itemBuilder: (BuildContext context, int index) {
                return Card(
                    color: const Color(0xFF6D7981),
                    child: ListTile(
                      title: Text(activitiesList[0].rubrics[index].name,
                          style: const TextStyle(
                            color: Colors.white,
                          )),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          for (int i = 1; i <= 5; i++)
                            IconButton(
                              icon: const Icon(Icons.star),
                              color:
                                  activitiesList[0].rubrics[index].score! >= i
                                      ? Colors.yellow
                                      : Colors.grey,
                              onPressed: () {
                                //ToDo: Add the logic to set the score individually
                                activitiesScreenCubit!
                                    .setScore(activitiesList, 0, index, i);
                                // setState(() {
                                //   _score1 = i;
                                // });
                                _sendScoreToFirebase(_score1, _score2);
                              },
                            ),
                        ],
                      ),
                    ));
              },
            ),
          )
        ]));
      } else {
        return Scaffold(
            body: ListView(children: <Widget>[
          ListTile(
            title: Text(activitiesList[0].title),
            subtitle: ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: activitiesList[0].rubrics.length,
              itemBuilder: (BuildContext context, int index) {
                return Card(
                    color: const Color(0xFF6D7981),
                    child: ListTile(
                      title: Text(activitiesList[0].rubrics[index].name,
                          style: const TextStyle(
                            color: Colors.white,
                          )),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          for (int i = 1; i <= 5; i++)
                            IconButton(
                              icon: const Icon(Icons.star),
                              color: _score1 >= i ? Colors.yellow : Colors.grey,
                              onPressed: null,
                            ),
                        ],
                      ),
                    ));
              },
            ),
          )
        ]));
      }
    });
    // return Text("Hello");
  }
}
