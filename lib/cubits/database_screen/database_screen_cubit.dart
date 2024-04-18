import 'package:feedback_flow/cubits/database_screen/database_screen_state.dart';
import 'package:feedback_flow/models/user.dart';
import 'package:feedback_flow/repository/user_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DatabaseScreenCubit extends Cubit<DatabaseScreenState> {
  // DatabaseScreenCubit(super.initialState);
  // List of userss from the database
  // Add your cubit methods here
  DatabaseScreenCubit() : super(DatabaseScreenInitial()) {
    subscribeToData();
  }

  final UserRepository _userrepo = UserRepository();

  void subscribeToData() async {
    // emit(DatabaseScreenInitial());
    try {
      _userrepo.roleBasedUsersRef.snapshots().listen((snapshot) {
        print("Reached Here");

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
}
