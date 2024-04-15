import 'package:feedback_flow/cubits/activities_screen/activities_screen_state.dart';
import 'package:feedback_flow/models/activity.dart';
import 'package:feedback_flow/models/user.dart';
import 'package:feedback_flow/repository/activity_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// Cubit
class ActivitiesScreenCubit extends Cubit<ActivitiesScreenState> {
  List<Activity>? upcomingActivities;
  List<Activity> pastActivities = [];
  // ActivitiesScreenCubit(this.upcomingActivities)
  //     : super(InitialState([]));

  final ActivityRepository _activityRepository = ActivityRepository();

  //TODO - Find better logic for fixing the state changes on load
  ActivitiesScreenCubit(this.upcomingActivities) : super(InitialState([])) {
    loadActivities();
  }

  void startActivity(List<Activity> activities, index) {
    activities[index].isStarted = true;
    emit(ActivityStarted(activities));
  }

  void addActivity(Activity activity) {
    _activityRepository.addActivity(activity);

    emit(ActivityAddedState(upcomingActivities!..add(activity)));
  }

  void loadActivities() async {
    try {
      upcomingActivities = await _activityRepository.getActivities();
      emit(ActivityLoadedState(upcomingActivities!));
    } catch (e) {
      print(e);
    }
    // await _activityRepository.getActivities().then((activities) {
    //   upcomingActivities = activities;
    //   emit(ActivityLoadedState(upcomingActivities!));
    // });
  }

//BM - temporary method to add activities
  // void addActivities() {
  //   _activityRepository.addActivities();
  // }

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
