import 'package:feedback_flow/cubits/activities_screen/activities_screen_state.dart';
import 'package:feedback_flow/models/activity.dart';
import 'package:feedback_flow/models/user.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// Cubit
class ActivitiesScreenCubit extends Cubit<ActivitiesScreenState> {
  List<Activity> upcomingActivities;
  List<Activity> pastActivities = [];
  ActivitiesScreenCubit(this.upcomingActivities)
      : super(InitialState(upcomingActivities));

  void startActivity(List<Activity> activities, index) {
    activities[index].isStarted = true;
    emit(ActivityStarted(activities));
  }

  void endActivity(List<Activity> activities, index) {
    activities[index].isCompleted = true;
    emit(ActivityEnded(activities));
  }

  void distributeResults(List<Activity> activities, index) {
    //Remove the distributed activity from the (upcoming) activities list
    activities[index].isDistributed = true;

    //Add the distributed activity to the (past) activities list
    pastActivities.add(activities[index]);
    activities.removeAt(index);
    // emit(ActivityEnded(activities));

    emit(ResultsDistributed(pastActivities, activities));
  }

  void setScore(List<Activity> activities, index, rubricIndex, score,
      UserModel presenter) {
    activities[index].rubrics[rubricIndex].score = score;
    // emit(ActivityScoreSet(activities));

    emit(ActivityStarted(activities));
  }
}
