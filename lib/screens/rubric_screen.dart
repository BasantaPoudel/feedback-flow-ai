import 'package:feedback_flow/cubits/activities_screen/activities_screen_cubit.dart';
import 'package:feedback_flow/cubits/activities_screen/activities_screen_state.dart';
import 'package:feedback_flow/cubits/database_screen/database_screen_cubit.dart';
import 'package:feedback_flow/models/activity.dart';
import 'package:feedback_flow/models/user.dart';
import 'package:feedback_flow/repository/score_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RubricScreen extends StatefulWidget {
  const RubricScreen({super.key, required this.activity});

  @override
  _RubricScreenState createState() => _RubricScreenState();
  final Activity activity;
}

class _RubricScreenState extends State<RubricScreen> {
  final ScoreRepository _scoreRepository = ScoreRepository();
  int _score2 = 0;
  int _score1 = 0;
  void _sendScoreToFirebase(UserModel presenter) {
    // Send the score to Firebase database
    _scoreRepository.sendScoreToFirebase(presenter);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // ScoreCubit? scoreCubit = BlocProvider.of<ScoreCubit>(context);
    DatabaseScreenCubit? databaseScreenCubit =
        BlocProvider.of<DatabaseScreenCubit>(context);

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

    return BlocProvider(
        create: (context) => DatabaseScreenCubit()..subscribeToData(),
        child: BlocBuilder<ActivitiesScreenCubit, ActivitiesScreenState>(
            builder: (context, stateActivity) {
          List<Activity> activitiesList = stateActivity.getUpcomingActivities;
          String presenterName = "";
          if (stateActivity is ActivityStarted) {
            if (databaseScreenCubit.state.props!.isNotEmpty) {
              var presenter = databaseScreenCubit.state.props!
                  .where((element) => element.isPresenter == true)
                  .first;

              String presenterName = presenter.name!;
              return Scaffold(
                  appBar: AppBar(
                    title: Text("Presenter: $presenterName"),
                  ),

                  // TODO - Display the selected activiy
                  body: ListView(children: <Widget>[
                    ListTile(
                      title: Text(widget.activity.title),
                      subtitle: ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: widget.activity.rubrics.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Card(
                              color: const Color(0xFF6D7981),
                              child: ListTile(
                                title: Text(widget.activity.rubrics[index].name,
                                    style: const TextStyle(
                                      color: Colors.white,
                                    )),
                                trailing: BlocBuilder<ActivitiesScreenCubit,
                                    ActivitiesScreenState>(
                                  builder: (context, stateActivity) {
                                    List<Activity> activitiesList =
                                        stateActivity.getUpcomingActivities;

                                    return Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        for (int i = 1; i <= 5; i++)
                                          IconButton(
                                            icon: const Icon(Icons.star),
                                            color: widget
                                                        .activity
                                                        .rubrics[index]
                                                        .score! >=
                                                    i
                                                ? Colors.yellow
                                                : Colors.grey,
                                            onPressed: () {
                                              //ToDo: Add the logic to set the score individually
                                              activitiesScreenCubit!.setScore(
                                                  activitiesList,
                                                  0,
                                                  index,
                                                  i,
                                                  presenter);
                                              // setState(() {
                                              //   _score1 = i;
                                              // });

                                              presenter.setActivities(
                                                  activitiesList);

                                              _sendScoreToFirebase(presenter);
                                            },
                                          ),
                                      ],
                                    );
                                  },
                                ),
                              ));
                        },
                      ),
                    )
                  ]));
            }
          } else {
            return Scaffold(
                appBar: AppBar(
                  title: Text("Rubrics List"),
                ),
                body: ListView(children: <Widget>[
                  ListTile(
                    title: Text(widget.activity.title),
                    subtitle: ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: widget.activity.rubrics.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Card(
                            color: const Color(0xFF6D7981),
                            child: ListTile(
                              title: Text(widget.activity.rubrics[index].name,
                                  style: const TextStyle(
                                    color: Colors.white,
                                  )),
                              trailing: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  for (int i = 1; i <= 5; i++)
                                    IconButton(
                                      icon: const Icon(Icons.star),
                                      color: _score1 >= i
                                          ? Colors.yellow
                                          : Colors.grey,
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
          return FittedBox();
        }));
  }
}
