import 'package:feedback_flow/models/activity.dart';

abstract class ResultScreenState {
  ResultScreenState();
  get props => null;
}

class ResultScreenInitial extends ResultScreenState {
  ResultScreenInitial();
}

class ResultScreenLoadedWithActivity extends ResultScreenState {
  Activity activity;

  ResultScreenLoadedWithActivity(this.activity);

  @override
  Activity get props => activity;
}

class ResultFromProfessor extends ResultScreenState {
  Activity activity;

  ResultFromProfessor(this.activity);

  @override
  Activity get props => activity;
}

class ResultFromStudents extends ResultScreenState {
  Activity activity;

  ResultFromStudents(this.activity);
  @override
  Activity get props => activity;
}
