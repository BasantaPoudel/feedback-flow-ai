import 'package:feedback_flow/cubits/act_screen/act_screen_cubit.dart';
import 'package:feedback_flow/cubits/home_screen/home_screen_cubit.dart';
import 'package:feedback_flow/cubits/presenters_screen/presenters_screen_cubit.dart';
import 'package:feedback_flow/cubits/result_screen/result_screen_cubit.dart';
import 'package:feedback_flow/cubits/rubric_screen/rubric_screen_cubit.dart';
import 'package:feedback_flow/cubits/score_screen/score_cubit.dart';
import 'package:feedback_flow/firebase_options.dart';
import 'package:feedback_flow/theme/app_theme.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'auth_gate.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(MultiBlocProvider(providers: [
    BlocProvider(
        create: (BuildContext context) =>
            PresenterScreenCubit()..subscribeToData()),
    BlocProvider(create: (BuildContext context) => ScoreCubit()),
    BlocProvider(create: (BuildContext context) => ActScreenCubit()),
    BlocProvider(create: (BuildContext context) => HomeScreenCubit()),
    BlocProvider(create: (BuildContext context) => RubricScreenCubit()),
    BlocProvider(create: (BuildContext context) => ResultScreenCubit())
  ], child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: AppTheme.themeData,
        darkTheme: AppTheme.darkTheme,
        home: const AuthGate());
  }
}
