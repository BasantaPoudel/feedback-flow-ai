import 'package:feedback_flow/models/user.dart';

class PresenterScreenState {
  // Add your state properties here
  late List<UserModel>? _users;

  PresenterScreenState.withUsers(this._users);
  PresenterScreenState();

  List<UserModel>? get props => _users;
}

class PresenterScreenInitial extends PresenterScreenState {
  // DatabaseScreenInitial(super.users);
  // Add your state properties here
}

class PresenterScreenLoading extends PresenterScreenState {
  // DatabaseScreenLoading(super.users);
  // Add your state properties here
}

class PresenterScreenLoaded extends PresenterScreenState {
  @override
  List<UserModel>? _users;

  PresenterScreenLoaded(this._users) : super.withUsers(_users);
  // DatabaseScreenLoaded(super.users);
  // Add your state properties here
}

class PresenterScreenError extends PresenterScreenState {
  // DatabaseScreenError(super.users);
  // Add your state properties here
}

class PresenterState extends PresenterScreenState {
  @override
  List<UserModel>? _users;

  PresenterState(this._users) : super.withUsers(_users);

  @override
  List<UserModel>? get props => _users;
}
