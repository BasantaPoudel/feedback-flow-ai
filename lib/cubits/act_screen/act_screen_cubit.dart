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
      emit(ActivityErrorLoading([], error: "Error loading activity"));
    });
  }

  void startActivity(List<Activity> activities, index) {
    try {
      activities[index].isStarted = true;

      _activityRepository.updateActivity(activities[index]);
      emit(ActivityStarted(activities));
    } catch (e) {
      throw Exception('Error starting activity: $e');
      // emit(ActivityErrorLoading(activities, error: "Error starting activity"));
    }
  }

  void addActivity(Activity activity) {
    //TODO - Cleanup the concepts of upcoming, past and all activities
    try {
      _activityRepository.addActivity(activity);
      state.getAllActivities!.add(activity);
      emit(ActivityAddedState(state.getAllActivities!));
    } catch (e) {
      emit(ActivityErrorLoading(upcomingActivities!,
          error: "Error adding activity"));
    }
  }

  void updateActivity(Activity activity) {
    try {
      _activityRepository.updateActivity(activity);
      state.getAllActivities!.add(activity);

      emit(ActivityAddedState(state.getAllActivities!));
    } catch (e) {
      emit(ActivityErrorLoading(upcomingActivities!,
          error: "Error updating activity"));
    }
  }

  void deleteActivity(Activity activity) {
    try {
      _activityRepository.deleteActivity(activity);
    } catch (e) {
      throw Exception('Error deleting activity: $e');

      /* emit(ActivityErrorLoading(upcomingActivities!,
          error: "Error deleting activity")); */
    }
  }

  void duplicateActivity(Activity activity) {
    try {
      _activityRepository.addActivity(activity);
    } catch (e) {
      throw Exception('Error duplicating activity: $e');
      // emit(ActivityErrorLoading(upcomingActivities!,
      //     error: "Error duplicating activity"));
    }
  }

  void addRubric(Activity activity, rubric) {
    try {
      activity.rubrics.entries.first.value.add(rubric);
      _activityRepository.updateActivity(activity);
    } catch (e) {
      emit(ActivityErrorLoading(upcomingActivities!,
          error: "Error adding rubric"));
    }
  }

  void endActivity(List<Activity> activities, index) {
    try {
      activities[index].isCompleted = true;
      _activityRepository.updateActivity(activities[index]);
      emit(ActivityEnded(activities));
    } catch (e) {
      throw Exception('Error ending activity: $e');
      // emit(ActivityErrorLoading(activities, error: "Error ending activity"));
    }
  }

  void distributeResults(List<Activity> activities, index) {
    try {
      activities[index].isDistributed = true;
      pastActivities.add(activities[index]);
      _activityRepository.updateActivity(activities[index]);
      emit(ResultsDistributed(activities));
    } catch (e) {
      emit(ActivityErrorLoading(activities,
          error: "Error distributing results"));
    }
  }

  void deleteRubric(activity, elementAt) {
    try {
      activity.rubrics.entries.first.value.remove(elementAt);
      _activityRepository.updateActivity(activity);
    } catch (e) {
      throw Exception('Error deleting rubric: $e');
      // emit(ActivityErrorLoading(upcomingActivities!,
      //     error: "Error deleting rubric"));
    }
  }
}
