part of 'credentials_bloc.dart';

sealed class CredentialsEvent extends Equatable {
  const CredentialsEvent();

  @override
  List<Object> get props => [];
}

class SignInUser extends CredentialsEvent {
  final String email;
  final String password;

  const SignInUser({required this.email, required this.password});
  @override
  List<Object> get props => [email, password];
}

class SignUpUser extends CredentialsEvent {
  final UserEntity user;

  const SignUpUser({required this.user});
  @override
  List<Object> get props => [user];
}
