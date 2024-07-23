import 'package:feedback_flow/models/activity.dart';

abstract class RubricScreenState {
  RubricScreenState();
  get activity => null;
}

class RubricScreenInitial extends RubricScreenState {
  RubricScreenInitial();
}

class RubricScoreUpdatedByProfessor extends RubricScreenState {
  @override
  Activity activity;
  RubricScoreUpdatedByProfessor(this.activity);
  @override
  Activity get props => activity;
}

class RubricScoreUpdatedByUser extends RubricScreenState {
  @override
  Activity activity;

  RubricScoreUpdatedByUser(this.activity);

  @override
  Activity get props => activity;
}
