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

  //Check why Score is 0 ot null eventhough it is set to 1 in this list
  List<Activity> activities = [
    Activity(
      title: 'Activity 1',
      rubrics: [
        Rubric(name: 'Rubric 1', score: 1),
        Rubric(name: 'Rubric 2', score: 1),
      ],
      isStarted: false,
    ),
    Activity(
      title: 'Activity 2',
      rubrics: [
        Rubric(name: 'Rubric 3', score: 1),
        Rubric(name: 'Rubric 4', score: 1),
      ],
      isStarted: false,
    ),
    // Add more activities as needed
  ];

  runApp(MultiBlocProvider(providers: [
    // BlocProvider<HomeScreenCubit>(
    //     create: (BuildContext context) => HomeScreenCubit()),

    //TODO - Refactor the constructor of ActivitiesScreenCubit
    BlocProvider(create: (BuildContext context) => ActivitiesScreenCubit([])),

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
          colorScheme: ColorScheme.fromSeed(
            seedColor: Color(0x00108EC5).toMaterialColor(),
            brightness: Brightness.light,
            //  const Color(0x00ffffff).toMaterialColor(),
          ),
          // // bottomNavigationBarTheme: BottomNavigationBarThemeData(
          //   // backgroundColor: const Color(0x00049ee0).toMaterialColor(),
          //   selectedItemColor: const Color(0x006D7981),
          //   unselectedItemColor: const Color(0x006D7981),
          // ),
          // // textTheme: const TextTheme(
          // //   displayLarge: TextStyle(
          // //       fontSize: 72.0, fontWeight: FontWeight.bold, color: Colors.red),
          // //   displayMedium:
          // //       TextStyle(fontSize: 36.0, fontStyle: FontStyle.italic),
          // //   displaySmall: TextStyle(fontSize: 14.0, fontFamily: 'Hind'),
          // // ),
        ),
        home: const AuthGate());
  }
}
