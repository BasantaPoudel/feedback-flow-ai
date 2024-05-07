import 'package:feedback_flow/cubits/activities_screen/activities_screen_cubit.dart';
import 'package:feedback_flow/cubits/activities_screen/activities_screen_state.dart';
import 'package:feedback_flow/cubits/presenters_screen/presenters_screen_cubit.dart';
import 'package:feedback_flow/models/activity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ResultsScreen extends StatefulWidget {
  const ResultsScreen({super.key, required this.activity});

  @override
  _ResultsScreenState createState() => _ResultsScreenState();
  final Activity activity;
}

class _ResultsScreenState extends State<ResultsScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    PresenterScreenCubit? presenterScreenCubit =
        BlocProvider.of<PresenterScreenCubit>(context);

    return BlocProvider(
        create: (context) => PresenterScreenCubit()..subscribeToData(),
        child: BlocBuilder<ActivitiesScreenCubit, ActivitiesScreenState>(
            builder: (context, stateActivity) {
          List<Activity> activitiesList =
              presenterScreenCubit.getUserActivities() ?? [];
          if (activitiesList.isEmpty) {
            return const Scaffold(
              body: Center(
                child: Text("No activities found"),
              ),
            );
          }
          var activity = activitiesList
              .where((element) => element.title == widget.activity.title)
              .first;

          return Scaffold(
            appBar: AppBar(
              title: Row(children: <Widget>[
                // First expanded widget with flex factor of 1
                Expanded(
                  flex: 1,
                  child: Container(
                    // height: 100,
                    // color: Colors.red,
                    child: const Text("Results"),
                  ),
                ),
                // Second expanded widget with flex factor of 2
                Expanded(
                  flex: 1,
                  child: Container(
                    // height: 100,
                    // color: Colors.green,
                    child: const Switch(
                        value: true,
                        activeColor: Colors.green,
                        inactiveThumbColor: Colors.blue,
                        onChanged: null),
                  ),
                )
              ]),
            ),
            body: ListView(children: <Widget>[
              ListTile(
                title: Text(widget.activity.title),
                subtitle: ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: activity.rubrics.entries.elementAt(0).value.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Card(
                        color: const Color(0xFF6D7981),
                        child: ListTile(
                            title: Text(
                                activity.rubrics.entries
                                        .elementAt(0)
                                        .value[index]
                                        .name ??
                                    "",
                                style: const TextStyle(
                                  color: Colors.white,
                                )),
                            trailing: Text(
                                activity.rubrics.entries
                                    .elementAt(0)
                                    .value[index]
                                    .score
                                    .toString(),
                                style: const TextStyle(
                                  color: Colors.white,
                                  //TODO - Remove hardcoded font size
                                  fontSize: 18,
                                ))));

                    // Row(
                    //       mainAxisSize: MainAxisSize.min,
                    //       children: [
                    //         for (int i = 1; i <= 5; i++)
                    //           IconButton(
                    //             //TODO - Chnage to const
                    //             icon: Icon(Icons.star),
                    //             color: widget.activity.rubrics.entries
                    //                         .elementAt(0)
                    //                         .value[index]
                    //                         .score! >=
                    //                     i
                    //                 ? Colors.yellow
                    //                 : Colors.grey,
                    //             onPressed: null,
                    //           ),
                    //       ],
                    //     );
                  },
                ),
              )
            ]),
          );
        }));
  }
}
