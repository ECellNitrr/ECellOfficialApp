part of 'quiz_details_cubit.dart';

abstract class QuizDetailsState extends Equatable {
  const QuizDetailsState();

  @override
  List<Object> get props => [];
}

class QuizDetailsInitial extends QuizDetailsState {
  const QuizDetailsInitial();
}

class QuizDetailsLoading extends QuizDetailsState {
  const QuizDetailsLoading();
}

class QuizDetailsSuccess extends QuizDetailsState {
  final List<QuizDetail> quizDetailsList;

  const QuizDetailsSuccess(this.quizDetailsList);

  @override
  List<Object> get props => [quizDetailsList];
}

class QuizDetailsError extends QuizDetailsState {
  final String message;

  const QuizDetailsError(this.message);

  @override
  List<Object> get props => [message];
}
