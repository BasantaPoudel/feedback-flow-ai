import 'package:feedback_flow/cubits/act_screen/act_screen_state.dart';
import 'package:feedback_flow/models/activity.dart';
import 'package:feedback_flow/repository/activity_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// Cubit
class ActScreenCubit extends Cubit<ActScreenState> {
  List<Activity>? upcomingActivities;
  List<Activity> pastActivities = [];

  final ActivityRepository _activityRepository = ActivityRepository();

  ActScreenCubit() : super(InitialState()) {
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
        emit(ActivityStarted(activities));
      } else if (activities.any((activity) =>
          activity.isCompleted == true && activity.isDistributed == false)) {
        emit(ActivityEnded(activities));
      }
    }, onError: (error) {
      emit(ActivityErrorLoading([]));
    });
  }

  void startActivity(List<Activity> activities, index) {
    activities[index].isStarted = true;

    _activityRepository.updateActivity(activities[index]);
    emit(ActivityStarted(activities));
  }

  void addActivity(Activity activity) {
    _activityRepository.addActivity(activity);
  }

  void updateActivity(Activity activity) {
    _activityRepository.updateActivity(activity);
  }

  void deleteActivity(Activity activity) {
    _activityRepository.deleteActivity(activity);
  }

  void duplicateActivity(Activity activity) {
    _activityRepository.addActivity(activity);
  }

  void addRubric(Activity activity, rubric) {
    activity.rubrics.entries.first.value.add(rubric);
    _activityRepository.updateActivity(activity);
  }

  void endActivity(List<Activity> activities, index) {
    activities[index].isCompleted = true;
    _activityRepository.updateActivity(activities[index]);
    emit(ActivityEnded(activities));
  }

  void distributeResults(List<Activity> activities, index) {
    activities[index].isDistributed = true;
    pastActivities.add(activities[index]);
    _activityRepository.updateActivity(activities[index]);
    emit(ResultsDistributed(activities));
  }
}
