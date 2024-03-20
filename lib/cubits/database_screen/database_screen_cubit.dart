import 'package:feedback_flow/cubits/database_screen/database_screen_state.dart';
import 'package:feedback_flow/models/user.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DatabaseScreenCubit extends Cubit<DatabaseScreenState> {
  // DatabaseScreenCubit(super.initialState);

  // List of userss from the database
  // Add your cubit methods here
  DatabaseScreenCubit() : super(DatabaseScreenInitial());

  selectPresenter(List<UserModel> users, index) {
    users[index].isPresenter = !(users[index].isPresenter!);
    print("[DatabaseScreenCubit] Researched selectPresenter");
    emit(PresenterState(users));
  }
}
