import 'package:feedback_flow/models/activity.dart';

abstract class ActScreenState {
  get getAllActivities => null;
  get getPastActivities => null;
}

class InitialState extends ActScreenState {}

class ActivityLoadedState extends ActScreenState {
  final List<Activity> allActivities;
  String? error;
  ActivityLoadedState(this.allActivities);
  @override
  get getAllActivities => allActivities;
}

class ActivityErrorLoading extends ActScreenState {
  final List<Activity> allActivities;
  String? error;
  ActivityErrorLoading(this.allActivities, {required String error});
  @override
  get getAllActivities => allActivities;

  get getError => error;
}

class ActivityAddedState extends ActScreenState {
  final List<Activity> allActivities;

  ActivityAddedState(this.allActivities);
  @override
  get getAllActivities => allActivities;
}

class ActivityStarted extends ActScreenState {
  final List<Activity> allActivities;

  ActivityStarted(this.allActivities);
  @override
  get getAllActivities => allActivities;
}

class ActivityEnded extends ActScreenState {
  final List<Activity> allActivities;

  ActivityEnded(this.allActivities);
  @override
  get getAllActivities => allActivities;
}

class ResultsDistributed extends ActScreenState {
  final List<Activity> allActivities;

  ResultsDistributed(this.allActivities);

  @override
  get getAllActivities => allActivities;
}

class ActivityScoreSet extends ActScreenState {
  final List<Activity> activities;

  ActivityScoreSet(this.activities);
  @override
  get getAllActivities => activities;
}
