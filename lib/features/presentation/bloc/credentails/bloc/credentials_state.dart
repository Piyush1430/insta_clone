part of 'credentials_bloc.dart';

sealed class CredentialsState extends Equatable {
  const CredentialsState();

  @override
  List<Object> get props => [];
}

class CredentialsInitial extends CredentialsState {}

class CredentialLoading extends CredentialsState {
  @override
  List<Object> get props => [];
}

class CredentialSuccess extends CredentialsState {
  @override
  List<Object> get props => [];
}

class CredentialFailure extends CredentialsState {
  @override
  List<Object> get props => [];
}
