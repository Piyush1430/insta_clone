import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

import 'package:insta_clone/features/domain/entities/user/user_entity.dart';
import 'package:insta_clone/features/domain/usecases/firebase_usecases/user/get_user_usecases.dart';
import 'package:insta_clone/features/domain/usecases/firebase_usecases/user/update_user_usecases.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final GetUserUseCases getUserUseCases;
  final GetUpdateUserUseCase getUpdateUserUseCase;
  UserBloc({
    required this.getUserUseCases,
    required this.getUpdateUserUseCase,
  }) : super(UserInitial()) {
    on<GetUser>(_getuser);
    on<UpdateUser>(_onUpdateUser);
  }

  Future<void> _getuser(
    GetUser event,
    Emitter<UserState> emit,
  ) async {
    emit(UserLoading());
    try {
      final streamResponse = getUserUseCases.call(event.user);
      streamResponse.listen(
        (users) => emit(
          UserLoaded(users: users),
        ),
      );
    } on SocketException catch (_) {
      emit(UserFailure());
    } catch (_) {
      emit(UserFailure());
    }
  }

  Future<void> _onUpdateUser(
    UpdateUser event,
    Emitter<UserState> emit,
  ) async {
    emit(UserLoading());
    try {
      await getUpdateUserUseCase.call(event.user);
    } on SocketException catch (_) {
      emit(UserFailure());
    } catch (_) {
      emit(UserFailure());
    }
  }
}
