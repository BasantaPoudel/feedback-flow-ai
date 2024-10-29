import 'package:feedback_flow/cubits/presenters_screen/presenters_screen_state.dart';
import 'package:feedback_flow/models/rubric.dart';
import 'package:feedback_flow/models/user.dart';
import 'package:feedback_flow/repository/user_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logger/logger.dart';

class PresenterScreenCubit extends Cubit<PresenterScreenState> {
  PresenterScreenCubit() : super(PresenterScreenInitial()) {
    subscribeToData();
  }

  final UserRepository _userRepo = UserRepository();

  final Logger log = Logger();
  void subscribeToData() async {
    try {
      _userRepo.roleBasedUsersRef.snapshots().listen((snapshot) {
        log.d("[Database-C - subscribeToData] Reached Here");
        var users =
            snapshot.docs.map((doc) => UserModel.fromMap(doc.data())).toList();
        if (users.any((user) => user.isPresenter == true)) {
          emit(PresenterState(users));
          log.d("[Database-C - subscribeToData] PresenterState Emitted");
        } else {
          emit(PresenterScreenLoaded(users));
        }
      });
    } catch (e) {
      log.d(e);
    }
  }

  selectPresenter(List<UserModel> users, index) {
    log.d("[DatabaseScreenCubit] Reached selectPresenter");
    users[index].isPresenter = !(users[index].isPresenter!);
    _userRepo.updateUser(users[index]);
    users.any((element) => element.isPresenter == true)
        ? emit(PresenterState(users))
        : emit(PresenterScreenLoaded(users));
  }

//TODO - Use this method for more than one presenter
  addActivity(List<UserModel> users, activity) {
    for (var user in users) {
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
        _userRepo.updateUser(user);
      }
    }
  }

  updatePresenterFeedbackByProfessor(UserModel presenter, activity) async {
    String uId;
    String userRole = await _userRepo.getUserRole();
    if (userRole == "professor") {
      uId = "professor";
    } else {
      uId = await _userRepo.getLoggedInUserId();
    }

    List<Rubric> rubricsFromProfessor = activity.rubrics[uId];

    var index = presenter.activities
        ?.indexWhere((element) => element.title == activity.title);
    presenter.activities?.elementAt(index!).isFeedbackByProfessor = true;

    if (presenter.activities?.elementAt(index!).rubrics["professor"] == null) {
      presenter.activities?.elementAt(index!).rubrics["professor"] = [];
      presenter.activities?.elementAt(index!).rubrics["professor"] =
          rubricsFromProfessor;
    } else {
      presenter.activities?.elementAt(index!).rubrics["professor"] =
          rubricsFromProfessor;
    }
    // _userRepo.updateUser(presenter);
    _userRepo.updateRubrics(rubricsFromProfessor, presenter, activity.title);
  }

  bool? checkIfFeedbackAlreadyProvidedByProfessor(
      UserModel presenter, activity) {
    var index = presenter.activities
        ?.indexWhere((element) => element.title == activity.title);
    return presenter.activities?.elementAt(index!).isFeedbackByProfessor;
  }

  updatePresenterActivityList(UserModel presenter, activity) async {
    //Remove the old logic as there was no activity initially but now the activity is loaded right when going to the rubric screen

    String uId;
    String userRole = await _userRepo.getUserRole();
    if (userRole == "professor") {
      uId = "professor";
    } else {
      uId = await _userRepo.getLoggedInUserId();
    }
    List<Rubric> rubricsFromUser = activity.rubrics[uId];

    var index = presenter.activities
        ?.indexWhere((element) => element.title == activity.title);

    if (presenter.activities?.elementAt(index!).rubrics[uId] == null) {
      presenter.activities?.elementAt(index!).rubrics[uId] = [];
      presenter.activities?.elementAt(index!).rubrics[uId] = rubricsFromUser;
    } else {
      presenter.activities?.elementAt(index!).rubrics[uId] = rubricsFromUser;
    }
    _userRepo.updateRubrics(rubricsFromUser, presenter, activity.title);
  }

  String getUserId() {
    return _userRepo.user!.uid;
  }

  Future<String> getUserRole() {
    return _userRepo.getUserRole();
  }

  String? getUserEmail() {
    return _userRepo.user!.email;
  }

  getPresenterActivities(List<UserModel> users) {
    List<UserModel> presenters =
        users.where((user) => user.isPresenter == true).toList();
    List<dynamic> activities = [];
    for (var presenter in presenters) {
      activities.addAll(presenter.activities ?? []);
    }
    return activities;
  }

  getUserActivities() {
    return _userRepo.getActivities();
  }

  Future<void> updateUserName(newName) async {
    UserModel loggedInUser = await _userRepo.getLoggedInUserAsUserModel();
    loggedInUser.setname(newName);
    _userRepo.addUserToFirestore(loggedInUser);
  }
}
