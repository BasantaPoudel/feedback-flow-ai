import 'package:feedback_flow/models/activity.dart';

abstract class RubricScreenState {
  RubricScreenState();
  get activity => null;
}

class RubricScreenInitial extends RubricScreenState {
  RubricScreenInitial();
}

class RubricLoadingState extends RubricScreenState {
  @override
  Activity activity;
  RubricLoadingState(this.activity);
  Activity get props => activity;
}

class RubricLoadedState extends RubricScreenState {
  @override
  Activity activity;
  RubricLoadedState(this.activity);
  Activity get props => activity;
}

class RubricScoreUpdatedByProfessor extends RubricScreenState {
  @override
  Activity activity;
  RubricScoreUpdatedByProfessor(this.activity);
  Activity get props => activity;
}

class RubricScoreUpdatedByUser extends RubricScreenState {
  @override
  Activity activity;

  RubricScoreUpdatedByUser(this.activity);

  Activity get props => activity;
}
