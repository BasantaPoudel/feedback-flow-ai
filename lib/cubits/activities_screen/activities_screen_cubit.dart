import 'package:feedback_flow/cubits/activities_screen/activities_screen_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// Cubit
class ActivitiesScreenCubit extends Cubit<ActivitiesScreenState> {
  ActivitiesScreenCubit() : super(InitialState());

  void startActivity() {
    emit(ActivityStarted());
  }

  void endActivity() {
    emit(ActivityEnded());
  }

  void distributeResults() {
    emit(ResultsDistributed());
  }
}
