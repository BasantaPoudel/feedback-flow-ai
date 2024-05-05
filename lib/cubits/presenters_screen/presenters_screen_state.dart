import 'package:feedback_flow/models/user.dart';

//TODO - Fix constructors and methods to properly set and get the values
class PresenterScreenState {
  // Add your state properties here
  late List<UserModel>? _users;

  PresenterScreenState.withUsers(this._users);
  PresenterScreenState();

  List<UserModel>? get props => _users;
}

class DatabaseScreenInitial extends PresenterScreenState {
  // DatabaseScreenInitial(super.users);
  // Add your state properties here
}

class DatabaseScreenLoading extends PresenterScreenState {
  // DatabaseScreenLoading(super.users);
  // Add your state properties here
}

class DatabaseScreenLoaded extends PresenterScreenState {
  @override
  List<UserModel>? _users;

  DatabaseScreenLoaded(this._users)
      : super.withUsers(_users); // DatabaseScreenLoaded(super.users);
  // Add your state properties here
}

class DatabaseScreenError extends PresenterScreenState {
  // DatabaseScreenError(super.users);
  // Add your state properties here
}

class PresenterState extends PresenterScreenState {
  // Add your state properties here
  @override
  List<UserModel>? _users;

  PresenterState(this._users) : super.withUsers(_users);

  @override
  List<UserModel>? get props => _users;
}
