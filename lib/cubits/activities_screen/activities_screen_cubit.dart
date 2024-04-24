import 'package:feedback_flow/cubits/activities_screen/activities_screen_state.dart';
import 'package:feedback_flow/models/activity.dart';
import 'package:feedback_flow/models/user.dart';
import 'package:feedback_flow/repository/activity_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// Cubit
class ActivitiesScreenCubit extends Cubit<ActivitiesScreenState> {
  List<Activity>? upcomingActivities;
  List<Activity> pastActivities = [];

  final ActivityRepository _activityRepository = ActivityRepository();

  ActivitiesScreenCubit() : super(InitialState()) {
    subscribeToData();
  }

  void subscribeToData() {
    _activityRepository.activitiesRef.snapshots().listen((snapshot) {
      var activities =
          snapshot.docs.map((doc) => Activity.fromSnapshot(doc)).toList();
      emit(ActivityLoadedState(activities));
      if (activities.any((activity) =>
          activity.isStarted == true &&
          activity.isDistributed == false &&
          activity.isCompleted == false)) {
        // emit(ResultsDistributed(activities));
        emit(ActivityStarted(activities));
      } else if (activities.any((activity) =>
          activity.isCompleted == true && activity.isDistributed == false)) {
        // Code to execute if there's any activity with isStarted as true
        emit(ActivityEnded(activities));
      }
    }, onError: (error) {
      emit(ActivityErrorLoading([]));
    });
    // Listening to PresenterState changes
  }

  void startActivity(List<Activity> activities, index) {
    activities[index].isStarted = true;

    _activityRepository.updateActivity(activities[index]);
    emit(ActivityStarted(activities));
  }

  void addActivity(Activity activity) {
    _activityRepository.addActivity(activity);

    emit(ActivityAddedState(upcomingActivities!..add(activity)));
  }

  void addRubric(Activity activity, rubric) {
    activity.rubrics.add(rubric);
    _activityRepository.updateActivity(activity);
    // emit(ActivityStarted(upcomingActivities!));
  }

//BM - temporary method to add activities
  // void addActivities() {
  //   _activityRepository.addActivities();
  // }

  void endActivity(List<Activity> activities, index) {
    activities[index].isCompleted = true;
    // activities[index].isStarted = false;
    _activityRepository.updateActivity(activities[index]);
    emit(ActivityEnded(activities));
  }

  void distributeResults(List<Activity> activities, index) {
    activities[index].isDistributed = true;

    pastActivities.add(activities[index]);
    _activityRepository.updateActivity(activities[index]);
    // activities.removeAt(index);
    emit(ResultsDistributed(activities));
  }

  void setScore(
      Activity activity, index, rubricIndex, score, UserModel presenter) {
    // emit(ActivityScoreSet(activities));
    List<Activity> activities = state.getUpcomingActivities;
    var actIndex = activities
        .indexOf(activities.firstWhere((act) => act.title == activity.title));
    activities.removeAt(actIndex);
    activity.rubrics[rubricIndex].score = score;
    activities.add(activity);

    emit(ActivityStarted(activities));
  }
}
