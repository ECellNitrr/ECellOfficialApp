import 'package:bloc/bloc.dart';
import 'package:ecellapp/core/res/errors.dart';
import 'package:ecellapp/core/res/strings.dart';
import 'package:ecellapp/core/utils/logger.dart';
import 'package:ecellapp/models/questions.dart';


import 'package:equatable/equatable.dart';

import '../quiz_repository.dart';




part 'quiz_state.dart';

class QuizCubit extends Cubit<QuizState> {
  final QuizRepository _QuizRepository;
  QuizCubit(this._QuizRepository) : super(QuizInitial());
  Future<void> getQuizList() async {
    try {
      emit(QuizLoading());
      List<Questions> QuizList = await _QuizRepository.getAllQuizes();
      print(QuizList);
      emit(QuizSuccess(QuizList));
    } on NetworkException {
      emit(QuizError(S.networkException));
    } on ValidationException catch (e) {
      emit(QuizError(e.description));
    } on UnknownException {
      emit(QuizError(S.unknownException));
    } catch (e) {
      Log.s(tag: "Quiz Cubit", message: "Unknown Error message:" + e.toString());
    }
  }
}
