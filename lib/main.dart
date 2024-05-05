import 'package:feedback_flow/cubits/activities_screen/activities_screen_cubit.dart';
import 'package:feedback_flow/cubits/presenters_screen/presenters_screen_cubit.dart';
import 'package:feedback_flow/cubits/score_screen/score_cubit.dart';
import 'package:feedback_flow/firebase_options.dart';
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

  runApp(MultiBlocProvider(providers: [
    BlocProvider(
        create: (BuildContext context) =>
            ActivitiesScreenCubit()..subscribeToData()),
    BlocProvider(
        create: (BuildContext context) =>
            PresenterScreenCubit()..subscribeToData()),
    BlocProvider(create: (BuildContext context) => ScoreCubit())
  ], child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData(
          primarySwatch: const Color(0x00049ee0).toMaterialColor(),
          colorScheme: ColorScheme.fromSeed(
            seedColor: const Color(0x00108EC5).toMaterialColor(),
            brightness: Brightness.light,
          ),
          bottomNavigationBarTheme: BottomNavigationBarThemeData(
            backgroundColor: const Color(0x00049ee0).toMaterialColor(),
          ),
        ),
        home: const AuthGate());
  }
}
