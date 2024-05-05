import 'package:feedback_flow/models/activity.dart';

// States
abstract class ActivitiesScreenState {
  get getAllActivities => null;
  get getPastActivities => null;
}

class InitialState extends ActivitiesScreenState {}

class ActivityLoadedState extends ActivitiesScreenState {
  final List<Activity> allActivities;

  ActivityLoadedState(this.allActivities);
  @override
  get getAllActivities => allActivities;
}

class ActivityErrorLoading extends ActivitiesScreenState {
  final List<Activity> allActivities;

  ActivityErrorLoading(this.allActivities);
  @override
  get getAllActivities => allActivities;
}

class ActivityAddedState extends ActivitiesScreenState {
  final List<Activity> allActivities;

  ActivityAddedState(this.allActivities);
  @override
  get getAllActivities => allActivities;
}

class ActivityStarted extends ActivitiesScreenState {
  final List<Activity> allActivities;

  ActivityStarted(this.allActivities);
  @override
  get getAllActivities => allActivities;
}

class ActivityEnded extends ActivitiesScreenState {
  final List<Activity> allActivities;

  ActivityEnded(this.allActivities);
  @override
  get getAllActivities => allActivities;
}

class ResultsDistributed extends ActivitiesScreenState {
  // final List<Activity> pastActivities;
  final List<Activity> allActivities;

  ResultsDistributed(this.allActivities);

  @override
  get getAllActivities => allActivities;

  // @override
  // get getPastActivities => pastActivities;
}

class ActivityScoreSet extends ActivitiesScreenState {
  final List<Activity> activities;

  ActivityScoreSet(this.activities);
  @override
  get getAllActivities => activities;
}
