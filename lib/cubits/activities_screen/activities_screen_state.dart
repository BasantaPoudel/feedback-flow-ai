import 'package:feedback_flow/models/activity.dart';

// States
abstract class ActivitiesScreenState {
  get getUpcomingActivities => null;
  get getPastActivities => null;
}

class InitialState extends ActivitiesScreenState {}

class ActivityLoadedState extends ActivitiesScreenState {
  final List<Activity> upComingActivities;

  ActivityLoadedState(this.upComingActivities);
  @override
  get getUpcomingActivities => upComingActivities;
}

class ActivityErrorLoading extends ActivitiesScreenState {
  final List<Activity> upComingActivities;

  ActivityErrorLoading(this.upComingActivities);
  @override
  get getUpcomingActivities => upComingActivities;
}

class ActivityAddedState extends ActivitiesScreenState {
  final List<Activity> upComingActivities;

  ActivityAddedState(this.upComingActivities);
  @override
  get getUpcomingActivities => upComingActivities;
}

class ActivityStarted extends ActivitiesScreenState {
  final List<Activity> upComingActivities;

  ActivityStarted(this.upComingActivities);
  @override
  get getUpcomingActivities => upComingActivities;
}

class ActivityEnded extends ActivitiesScreenState {
  final List<Activity> upComingActivities;

  ActivityEnded(this.upComingActivities);
  @override
  get getUpcomingActivities => upComingActivities;
}

class ResultsDistributed extends ActivitiesScreenState {
  // final List<Activity> pastActivities;
  final List<Activity> upComingActivities;

  ResultsDistributed(this.upComingActivities);

  @override
  get getUpcomingActivities => upComingActivities;

  // @override
  // get getPastActivities => pastActivities;
}

class ActivityScoreSet extends ActivitiesScreenState {
  final List<Activity> activities;

  ActivityScoreSet(this.activities);
  @override
  get getUpcomingActivities => activities;
}
