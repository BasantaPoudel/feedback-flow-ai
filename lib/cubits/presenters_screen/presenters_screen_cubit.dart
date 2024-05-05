import 'package:feedback_flow/cubits/presenters_screen/presenters_screen_state.dart';
import 'package:feedback_flow/models/user.dart';
import 'package:feedback_flow/repository/user_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PresenterScreenCubit extends Cubit<PresenterScreenState> {
  // DatabaseScreenCubit(super.initialState);
  // List of userss from the database
  // Add your cubit methods here
  PresenterScreenCubit() : super(DatabaseScreenInitial()) {
    subscribeToData();
  }

  final UserRepository _userrepo = UserRepository();

  void subscribeToData() async {
    // emit(DatabaseScreenInitial());
    try {
      _userrepo.roleBasedUsersRef.snapshots().listen((snapshot) {
        print("[Database-C - subscribeToData] Reached Here");

        var users =
            snapshot.docs.map((doc) => UserModel.fromSnapshot(doc)).toList();

        if (users.any((user) => user.isPresenter == true)) {
          // Code to execute if there's any activity with isStarted as true
          emit(PresenterState(users));
        } else {
          emit(DatabaseScreenLoaded(users));
        }
      });
    } catch (e) {
      print(e);
    }
  }

  selectPresenter(List<UserModel> users, index) {
    print("[DatabaseScreenCubit] Reached selectPresenter");
    users[index].isPresenter = !(users[index].isPresenter!);

    _userrepo.updateUser(users[index]);

    users.any((element) => element.isPresenter == true)
        ? emit(PresenterState(users))
        : emit(DatabaseScreenLoaded(users));
  }

//TODO - Use this method for more than one presenter
  addActivity(List<UserModel> users, activity) {
    users.forEach((user) {
      if (user.isPresenter == true) {
        user.activities ??= [];

        if (user.activities!
            .where((ac) => ac.title == activity.title)
            .isNotEmpty) {
          user.activities!.removeWhere((ac) => ac.title == activity.title);
          user.activities!.add(activity);
        } else {
          user.activities!.add(activity);
        }
        _userrepo.updateUser(user);
      }
    });
  }

  updateActivity(UserModel user, activity) {
    if (user.isPresenter == true) {
      user.activities ??= [];
      if (user.activities!
          .where((ac) => ac.title == activity.title)
          .isNotEmpty) {
        user.activities!.removeWhere((ac) => ac.title == activity.title);
        user.activities!.add(activity);
      } else {
        user.activities!.add(activity);
      }
      _userrepo.updateUser(user);
    }
  }

  String getUserId() {
    return _userrepo.user!.uid;
  }

  getPresenterActivities(List<UserModel> users) {
    List<UserModel> presenters =
        users.where((user) => user.isPresenter == true).toList();
    List<dynamic> activities = [];
    presenters.forEach((presenter) {
      activities.addAll(presenter.activities ?? []);
    });
    return activities;
  }
}
