// Define the state for the ScoreCubit
abstract class ScoreState {
  final int score;

  ScoreState(this.score);
}

class InitialState extends ScoreState {
  InitialState() : super(0);
}

class IncrementState extends ScoreState {
  IncrementState(super.score);
}

class DecrementState extends ScoreState {
  DecrementState(super.score);
}

class ScoreSetState extends ScoreState {
  ScoreSetState(int score) : super(score);
}
