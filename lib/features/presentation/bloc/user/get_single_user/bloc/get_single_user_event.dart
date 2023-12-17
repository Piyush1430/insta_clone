part of 'get_single_user_bloc.dart';

sealed class GetSingleUserEvent extends Equatable {
  const GetSingleUserEvent();

  @override
  List<Object> get props => [];
}

 class GetSingleUser extends GetSingleUserEvent {
  final String uid;

  const GetSingleUser({required this.uid});
  @override
  List<Object> get props => [uid];
}
