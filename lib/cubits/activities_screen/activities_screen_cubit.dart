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

  void subscribeToData() {
    emit(InitialState([]));
    _activityRepository.activitiesRef.snapshots().listen((snapshot) {
      // if (snapshot.docs.isEmpty) {
      //   emit(ActivityErrorLoading([]));
      //   return;
      // }
      emit(ActivityLoadedState(
          snapshot.docs.map((doc) => Activity.fromSnapshot(doc)).toList()));

      var activities =
          snapshot.docs.map((doc) => Activity.fromSnapshot(doc)).toList();
      if (activities.any((activity) => activity.isStarted == true)) {
        // Code to execute if there's any activity with isStarted as true
        emit(ActivityStarted(activities));
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

  void loadActivities() async {
    try {
      // upcomingActivities = await _activityRepository.getActivities();
      _activityRepository.activitiesRef.snapshots().listen((snapshot) {
        // if (snapshot.docs.isEmpty) {
        //   emit(ActivityErrorLoading([]));
        //   return;
        // }
        emit(ActivityLoadedState(
            snapshot.docs.map((doc) => Activity.fromSnapshot(doc)).toList()));

        var activities =
            snapshot.docs.map((doc) => Activity.fromSnapshot(doc)).toList();
        if (activities.any((activity) => activity.isStarted == true)) {
          // Code to execute if there's any activity with isStarted as true
          emit(ActivityStarted(activities));
        }
      }, onError: (error) {
        emit(ActivityErrorLoading([]));
      });

      // emit(ActivityLoadedState(upcomingActivities!));
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

  void setScore(
      Activity activity, index, rubricIndex, score, UserModel presenter) {
    // emit(ActivityScoreSet(activities));
    List<Activity> activities = state.getUpcomingActivities;
    var actIndex = activities.indexOf(activity);
    activities.removeAt(actIndex);
    activity.rubrics[rubricIndex].score = score;
    activities.add(activity);

    emit(ActivityStarted(activities));
  }
}
