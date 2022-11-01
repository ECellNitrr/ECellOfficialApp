part of 'quiz_cubit.dart';








abstract class QuizState extends Equatable {
  const QuizState();

  @override
  List<Object> get props => [];
}

class QuizInitial extends QuizState {
  const QuizInitial();
}

class QuizLoading extends QuizState {
  const QuizLoading();
}

class QuizSuccess extends QuizState {
  final List<Questions> QuizList;

  const QuizSuccess(this.QuizList);

  @override
  List<Object> get props => [QuizList];
}

class QuizError extends QuizState {
  final String message;

  const QuizError(this.message);

  @override
  List<Object> get props => [message];
}