part of 'auth_bloc.dart';

sealed class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

class AppStarted extends AuthEvent {
  final BuildContext context;

  const AppStarted({required this.context});
  @override
  List<Object> get props => [context];
}

class LogIn extends AuthEvent {
  @override
  List<Object> get props => [];
}

class LogOut extends AuthEvent {
  @override
  List<Object> get props => [];
}
