import 'package:feedback_flow/cubits/activities_screen/activities_screen_state.dart';
import 'package:feedback_flow/models/activity.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// Cubit
class ActivitiesScreenCubit extends Cubit<ActivitiesScreenState> {
  List<Activity> activities;
  ActivitiesScreenCubit(this.activities) : super(InitialState(activities));

  void startActivity(List<Activity> activities, index) {
    activities[index].isStarted = true;
    emit(ActivityStarted(activities));
  }

  void endActivity(List<Activity> activities, index) {
    activities[index].isCompleted = true;
    emit(ActivityEnded(activities));
  }

  void distributeResults(List<Activity> activities, index) {
    activities[index].isDistributed = true;
    emit(ResultsDistributed(activities));
  }

  void setScore(List<Activity> activities, index, rubricIndex, score) {
    activities[index].rubrics[rubricIndex].score = score;
    emit(ActivityScoreSet(activities));
  }
}
