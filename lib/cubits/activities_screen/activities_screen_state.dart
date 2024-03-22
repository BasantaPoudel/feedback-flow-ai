import 'package:feedback_flow/models/activity.dart';

// States
abstract class ActivitiesScreenState {
  get getActivities => null;
}

class InitialState extends ActivitiesScreenState {
  final List<Activity> activities;

  InitialState(this.activities);

  @override
  get getActivities => activities;
}

class ActivityStarted extends ActivitiesScreenState {
  final List<Activity> activities;

  ActivityStarted(this.activities);
  @override
  get getActivities => activities;
}

class ActivityEnded extends ActivitiesScreenState {
  final List<Activity> activities;

  ActivityEnded(this.activities);
  @override
  get getActivities => activities;
}

class ResultsDistributed extends ActivitiesScreenState {
  final List<Activity> activities;

  ResultsDistributed(this.activities);
  @override
  get getActivities => activities;
}
