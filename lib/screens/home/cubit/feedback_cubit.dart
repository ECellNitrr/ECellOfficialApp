import 'package:bloc/bloc.dart';
import 'package:ecellapp/core/res/errors.dart';
import 'package:ecellapp/core/res/strings.dart';
import 'package:ecellapp/core/utils/logger.dart';
import 'package:ecellapp/screens/home/home_repository.dart';
import 'package:equatable/equatable.dart';

part 'feedback_state.dart';

class FeedbackCubit extends Cubit<FeedbackState> {
  final HomeRepository _homeRepository;
  FeedbackCubit(this._homeRepository) : super(FeedbackInitial());

  Future<void> postFeedback(String feedback) async {
    try {
      emit(FeedbackLoading());
      await _homeRepository.postFeedback(feedback);
      emit(FeedbackSuccess());
    } on NetworkException {
      emit(FeedbackError(S.networkException));
    } on ValidationException catch (e) {
      emit(FeedbackError(e.description));
    } on UnknownException {
      emit(FeedbackError(S.unknownException));
    } catch (e) {
      Log.s(tag: "Weird exception", message: "Weird response message ->" + e);
    }
  }
}
