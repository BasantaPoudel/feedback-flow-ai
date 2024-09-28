import 'package:feedback_flow/cubits/result_screen/result_screen_state.dart';
import 'package:feedback_flow/models/activity.dart';
import 'package:feedback_flow/models/rubric.dart';
import 'package:feedback_flow/repository/user_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ResultScreenCubit extends Cubit<ResultScreenState> {
  ResultScreenCubit() : super(ResultScreenInitial());
  final UserRepository _userRepository = UserRepository();

  loadResultFromProfessor(Activity activity) async {
    emit(ResultFromProfessor(activity));
  }

  calculateAndLoadActivity(Activity activity) async {
    List<Activity> userActivities = await _userRepository.getActivities();

    Activity userActivity =
        userActivities.firstWhere((element) => element.title == activity.title);

    List<Rubric> rubricFromProfessor =
        userActivity.rubrics["7voEBXOmHybCnuJbIhDbk778Zvk2"]!;
    userActivity.rubrics.remove("7voEBXOmHybCnuJbIhDbk778Zvk2");
    List<Rubric> rubricWithAverageScore =
        calculateAverageScoresfromRubricsEntries(userActivity.rubrics);

    userActivity.rubrics.clear();
    userActivity.rubrics["students"] = rubricWithAverageScore;
    userActivity.rubrics["professor"] = rubricFromProfessor;

    emit(ResultFromProfessor(userActivity));
  }

  loadResultFromStudents(Activity activity) {
    emit(ResultFromStudents(activity));
  }

  calculateAverageScoresfromRubricsEntries(Map<String, List<Rubric>> rubrics) {
    List<Rubric> tempRubricList = [];
    var length = rubrics.entries.length;
    rubrics.forEach((key, value) {
      tempRubricList.addAll(value);
    });

    List<Rubric> selectedRubricList = [];
    Map<String, double> rubricMap = {};

    for (var rubric in tempRubricList) {
      if (rubricMap.containsKey(rubric.title)) {
        rubricMap[rubric.title] = rubricMap[rubric.title]! + rubric.score;
      } else {
        rubricMap[rubric.title] = rubric.score;
      }
    }

    rubricMap.forEach((key, value) {
      selectedRubricList.add(Rubric(title: key, score: value));
    });

    for (var rubric in selectedRubricList) {
      rubric.score = rubric.score / length.toDouble();
    }

    return selectedRubricList;
  }
}
