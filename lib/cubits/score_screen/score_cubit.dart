import 'package:feedback_flow/cubits/score_screen/score_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ScoreCubit extends Cubit<ScoreState> {
  ScoreCubit() : super(InitialState());

  void incrementScore() {
    emit(IncrementState(state.score + 1));
  }

  void decrementScore() {
    emit(DecrementState(state.score - 1));
  }

  void resetScore() {
    emit(InitialState());
  }

  void setScore(int score) {
    emit(ScoreSetState(score));
  }
}
