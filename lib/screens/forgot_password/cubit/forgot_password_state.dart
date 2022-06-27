part of 'forgot_password_cubit.dart';

@immutable
abstract class ForgotPasswordState extends Equatable {
  const ForgotPasswordState();

  @override
  List<Object> get props => [];
}

class ForgotLoading extends ForgotPasswordState {}

class ForgotEmailInitial extends ForgotPasswordState {}

class ForgotOTPInitial extends ForgotPasswordState {}

class ForgotPasswordError extends ForgotPasswordState {
  final String message;
  final ForgotPasswordState state;

  ForgotPasswordError(this.message, this.state);
}

class ForgotResetInitial extends ForgotPasswordState {}

class ForgotResetSuccess extends ForgotPasswordState {}
