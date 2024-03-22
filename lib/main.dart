import 'package:feedback_flow/cubits/activities_screen/activities_screen_cubit.dart';
import 'package:feedback_flow/cubits/database_screen/database_screen_cubit.dart';
import 'package:feedback_flow/cubits/score_screen/score_cubit.dart';
import 'package:feedback_flow/firebase_options.dart';
import 'package:feedback_flow/models/activity.dart';
import 'package:feedback_flow/models/rubric.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_color_gen/material_color_gen.dart';

import 'auth_gate.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  List<Activity> activities = [
    Activity(
      title: 'Activity 1',
      rubrics: [
        Rubric(name: 'Rubric 1', score: 0),
        Rubric(name: 'Rubric 2', score: 0),
      ],
    ),
    Activity(
      title: 'Activity 2',
      rubrics: [
        Rubric(name: 'Rubric 3', score: 0),
        Rubric(name: 'Rubric 4', score: 0),
      ],
    ),
    // Add more activities as needed
  ];

  runApp(MultiBlocProvider(providers: [
    // BlocProvider<HomeScreenCubit>(
    //     create: (BuildContext context) => HomeScreenCubit()),

    BlocProvider(
        create: (BuildContext context) => ActivitiesScreenCubit(activities)),

    BlocProvider(create: (BuildContext context) => DatabaseScreenCubit()),
    BlocProvider(create: (BuildContext context) => ScoreCubit())
  ], child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    //TODO - Refactor if the BlocProvider is not needed
    return MaterialApp(
        theme: ThemeData(
          primarySwatch: const Color(0x00049ee0).toMaterialColor(),
        ),
        home: const AuthGate());
  }
}
