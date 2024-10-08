import 'package:feedback_flow/cubits/presenters_screen/presenters_screen_cubit.dart';
import 'package:feedback_flow/cubits/result_screen/result_screen_cubit.dart';
import 'package:feedback_flow/cubits/result_screen/result_screen_state.dart';
import 'package:feedback_flow/models/activity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ResultsScreen extends StatefulWidget {
  const ResultsScreen({super.key});

  @override
  State<ResultsScreen> createState() => _ResultsScreenState();
}

class _ResultsScreenState extends State<ResultsScreen> {
  bool defaultSwitchValue = true;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ResultScreenCubit resultScreenCubit =
        BlocProvider.of<ResultScreenCubit>(context);

    return BlocProvider(
        create: (context) => PresenterScreenCubit()..subscribeToData(),
        child: BlocBuilder<ResultScreenCubit, ResultScreenState>(
            buildWhen: (previous, current) =>
                current is ResultFromProfessor || current is ResultFromStudents,
            builder: (context, resultState) {
              Activity? activity = resultScreenCubit.state.props;
              if (activity == null || activity.rubrics.isEmpty) {
                return const Scaffold(
                  body: Center(
                    child:
                        Text("Sorry, you didn't participate in this activity."),
                  ),
                );
              }

              return Scaffold(
                appBar: AppBar(
                  title: Row(children: <Widget>[
                    const Expanded(
                      flex: 1,
                      child: Text("Results"),
                    ),
                    Expanded(
                      flex: 1,
                      child: Row(
                        children: [
                          const Text('S'),
                          Switch(
                              value: defaultSwitchValue,
                              activeColor: Colors.green,
                              inactiveThumbColor: Colors.blue,
                              onChanged: (bool value) {
                                setState(() {
                                  defaultSwitchValue = value;
                                });
                                //TODO - Add the logic to display individual scores for each task
                                resultScreenCubit.state is ResultFromStudents
                                    ? resultScreenCubit
                                        .loadResultFromProfessor(activity)
                                    : resultScreenCubit
                                        .loadResultFromStudents(activity);
                              }),
                          const Text('T'),
                        ],
                      ),
                    )
                  ]),
                ),
                body: ListView(children: <Widget>[
                  ListTile(
                    title: Text(activity.title),
                    subtitle: ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount:
                          activity.rubrics.entries.elementAt(0).value.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Card(
                            color: const Color(0xFF6D7981),
                            child: ListTile(
                              title: Text(
                                  activity.rubrics.entries
                                      .elementAt(0)
                                      .value[index]
                                      .title,
                                  style: const TextStyle(
                                    color: Colors.white,
                                  )),
                              trailing: BlocBuilder<ResultScreenCubit,
                                  ResultScreenState>(builder: (context, state) {
                                String key = "";
                                if (state is ResultFromProfessor) {
                                  key = "professor";
                                } else if (state is ResultFromStudents) {
                                  key = "students";
                                }

                                return Text(
                                    activity.rubrics[key]!
                                        .elementAt(index)
                                        .score
                                        .toString(),
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 20,
                                    ));
                              }),
                            ));
                      },
                    ),
                  )
                ]),
              );
            }));
  }
}
