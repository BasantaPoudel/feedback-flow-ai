import 'package:feedback_flow/cubits/rubric_screen/rubric_screen_state.dart';
import 'package:feedback_flow/models/activity.dart';
import 'package:feedback_flow/models/rubric.dart';
import 'package:feedback_flow/models/user.dart';
import 'package:feedback_flow/repository/user_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// Define the state for the RubricScreenCubit

// Define the cubit for the RubricScreen
class RubricScreenCubit extends Cubit<RubricScreenState> {
  RubricScreenCubit() : super(RubricScreenInitial());
  final UserRepository _userRepository = UserRepository();

  void updateRubricScore(Activity activity, UserModel presenter) {
    emit(RubricScoreUpdatedByProfessor(activity));
  }

  void setScore(
      Activity activity, rubricIndex, score, UserModel presenter) async {
    String userId = await _userRepository.getLoggedInUserId();
    if (activity.rubrics[userId] == null) {
      activity.rubrics[userId] = [];
      List<Rubric> rubrics =
          activity.rubrics.entries.first.value.map((e) => e).toList();

      List<Rubric> copiedRubrics = [];

      //Deep copy the rubrics
      for (var obj in rubrics) {
        copiedRubrics.add(Rubric(
            name: obj.name,
            score: obj
                .score)); // Assuming MyClass has a constructor that takes an ID
      }
      activity.rubrics[userId] = copiedRubrics;
    }
    List<Rubric> rubrics = activity.rubrics[userId]!;
    rubrics.elementAt(rubricIndex).score = score;
    if (activity.rubrics[userId] == null) {
      activity.rubrics[userId] = [];
      activity.rubrics[userId] = rubrics;
    } else {
      activity.rubrics[userId] = rubrics;
    }
    activity.rubrics[userId]?.elementAt(rubricIndex).score = score;
    // presenter.activities?.add(activity);
    emit(RubricScoreUpdatedByProfessor(activity));
  }

  addActivityByProfessor(Activity activity, UserModel presenter) async {
    _userRepository.addActivityWithDefaultRubricToPresenter(
        presenter, activity);
    emit(RubricScoreUpdatedByProfessor(activity));
  }

  addActivityToRubricState(Activity activity, UserModel presenter) async {
    emit(RubricScoreUpdatedByProfessor(activity));
  }
}
