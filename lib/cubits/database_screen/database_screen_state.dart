import 'package:feedback_flow/models/user.dart';
import 'package:firebase_auth/firebase_auth.dart';

//TODO - Fix constructors and methods to properly set and get the values
class DatabaseScreenState {
  // Add your state properties here
  late List<UserModel>? _users;

  DatabaseScreenState.withUsers(this._users);
  DatabaseScreenState();
}

class DatabaseScreenInitial extends DatabaseScreenState {
  // DatabaseScreenInitial(super.users);
  // Add your state properties here
}

class DatabaseScreenLoading extends DatabaseScreenState {
  // DatabaseScreenLoading(super.users);
  // Add your state properties here
}

class DatabaseScreenLoaded extends DatabaseScreenState {
  List<UserModel>? _users;

  DatabaseScreenLoaded(this._users)
      : super.withUsers(_users); // DatabaseScreenLoaded(super.users);
  // Add your state properties here
}

class DatabaseScreenError extends DatabaseScreenState {
  // DatabaseScreenError(super.users);
  // Add your state properties here
}

class PresenterState extends DatabaseScreenState {
  // Add your state properties here
  List<UserModel>? _users;

  PresenterState(this._users) : super.withUsers(_users);
  List<UserModel>? get props => _users;
}
