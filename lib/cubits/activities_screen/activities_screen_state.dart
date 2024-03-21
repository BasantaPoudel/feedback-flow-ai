import 'package:flutter_bloc/flutter_bloc.dart';

// States
abstract class ActivitiesScreenState {}

class InitialState extends ActivitiesScreenState {}

class ActivityStarted extends ActivitiesScreenState {}

class ActivityEnded extends ActivitiesScreenState {}

class ResultsDistributed extends ActivitiesScreenState {}
