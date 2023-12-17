part of 'user_bloc.dart';

sealed class UserEvent extends Equatable {
  const UserEvent();

  @override
  List<Object> get props => [];
}

class GetUser extends UserEvent {
  final UserEntity user;

  const GetUser({required this.user});
  @override
  List<Object> get props => [user];
}

class UpdateUser extends UserEvent {
  final UserEntity user;

  const UpdateUser({required this.user});
  @override
  List<Object> get props => [user];
}
