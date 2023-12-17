part of 'get_single_user_bloc.dart';

sealed class GetSingleUserState extends Equatable {
  const GetSingleUserState();

  @override
  List<Object> get props => [];
}

 class GetSingleUserInitial extends GetSingleUserState {}

class GetSingleUserLoading extends GetSingleUserState {
  @override
  List<Object> get props => [];
}

class GetSingleUserLoaded extends GetSingleUserState {
  final UserEntity user;

  const GetSingleUserLoaded({required this.user});
  @override
  List<Object> get props => [user];
}

class GetSingleUserFailure extends GetSingleUserState {
  @override
  List<Object> get props => [];
}
