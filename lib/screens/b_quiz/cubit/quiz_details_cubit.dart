import 'package:bloc/bloc.dart';
import 'package:ecellapp/core/res/errors.dart';
import 'package:ecellapp/core/res/strings.dart';
import 'package:ecellapp/core/utils/logger.dart';
import 'package:ecellapp/models/questions.dart';
import 'package:ecellapp/models/quiz_details.dart';
import 'package:ecellapp/screens/b_quiz/quiz_detail_repository.dart';

import 'package:equatable/equatable.dart'; 

part 'quiz_details_state.dart';

class QuizDetailCubit extends Cubit<QuizDetailsState> {
  final QuizDetailRepository _QuizDetailRepository;
  QuizDetailCubit(this._QuizDetailRepository) : super(QuizDetailsInitial());
  Future<void> getQuizDetailsList() async {
    try {
      emit(QuizDetailsLoading());
      List<QuizDetail> quizDetailsList = await _QuizDetailRepository.getAllQuizesDetails();
      print(quizDetailsList);
      emit(QuizDetailsSuccess(quizDetailsList));
    } on NetworkException {
      emit(QuizDetailsError(S.networkException));
    } on ValidationException catch (e) {
      emit(QuizDetailsError(e.description));
    } on UnknownException {
      emit(QuizDetailsError(S.unknownException));
    } catch (e) {
      Log.s(
          tag: "Quiz Cubit", message: "Unknown Error message:" + e.toString());
    }
  }
}
