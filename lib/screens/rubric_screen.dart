import 'package:feedback_flow/cubits/activities_screen/activities_screen_cubit.dart';
import 'package:feedback_flow/cubits/activities_screen/activities_screen_state.dart';
import 'package:feedback_flow/cubits/database_screen/database_screen_cubit.dart';
import 'package:feedback_flow/models/activity.dart';
import 'package:feedback_flow/models/rubric.dart';
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
  void _sendScoreToFirebase(UserModel presenter) {
    _scoreRepository.sendScoreToFirebase(presenter);
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    DatabaseScreenCubit? databaseScreenCubit =
        BlocProvider.of<DatabaseScreenCubit>(context);

    ActivitiesScreenCubit? activitiesScreenCubit =
        BlocProvider.of<ActivitiesScreenCubit>(context);

    return BlocProvider(
        create: (context) => DatabaseScreenCubit()..subscribeToData(),
        child: BlocBuilder<ActivitiesScreenCubit, ActivitiesScreenState>(
            builder: (context, stateActivity) {
          if (stateActivity is ActivityStarted && widget.activity.isStarted) {
            if (databaseScreenCubit.state.props!.isNotEmpty) {
              var presenter = databaseScreenCubit.state.props!
                  .where((element) => element.isPresenter == true)
                  .first;
              String presenterName = presenter.name!;
              return Scaffold(
                appBar: AppBar(
                  title: Text("Presenter: $presenterName"),
                ),
                body: ListView(
                  children: <Widget>[
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
                                                  widget.activity,
                                                  0,
                                                  index,
                                                  i,
                                                  presenter);

                                              presenter.setActivities(
                                                  activitiesList);
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
                    ElevatedButton(
                      onPressed: () {
                        //ToDo: Add the logic to set the score individually
                        _sendScoreToFirebase(presenter);
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
                            ));
                      },
                    ),
                  )
                ]),
                floatingActionButton: FloatingActionButton(
                  onPressed: () {
                    activitiesScreenCubit!.addRubric(
                        widget.activity,
                        Rubric(
                          name: 'New Rubric from Rubric Screen',
                          score: 0,
                        ));
                  },
                  child: const Icon(Icons.add),
                ));
          }
          return FittedBox();
        }));
  }
}
