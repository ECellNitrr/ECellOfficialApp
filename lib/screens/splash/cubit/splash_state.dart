part of 'splash_cubit.dart';

abstract class SplashState extends Equatable {
  const SplashState();

  @override
  List<Object> get props => [];
}

class SplashLoading extends SplashState {
  const SplashLoading();
}

class SplashSuccess extends SplashState {
  final User user;
  const SplashSuccess(this.user);
  @override
  List<Object> get props => [user];
}

class SplashError extends SplashState {
  final String message;
  const SplashError(this.message);
  @override
  List<Object> get props => [message];
}
