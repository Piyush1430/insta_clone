// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:insta_clone/features/domain/entities/user/user_entity.dart';
import 'package:insta_clone/features/domain/usecases/firebase_usecases/user/get_single_user_usecase.dart';

part 'get_single_user_event.dart';
part 'get_single_user_state.dart';

class GetSingleUserBloc extends Bloc<GetSingleUserEvent, GetSingleUserState> {
  final GetSingleUserUseCase getSingleUserUseCase;
  GetSingleUserBloc({
    required this.getSingleUserUseCase,
  }) : super(GetSingleUserInitial()) {
    on<GetSingleUser>(_onGetSingleUser);
  }

  Future<void> _onGetSingleUser(
    GetSingleUser event,
    Emitter<GetSingleUserState> emit,
  ) async {
    emit(GetSingleUserLoading());
    try {
      final streamResponse = getSingleUserUseCase.call(event.uid);
      streamResponse.listen((users) {
        emit(GetSingleUserLoaded(user: users.first));
      });
    } on SocketException catch (_) {
      emit(GetSingleUserFailure());
    } catch (_) {
      emit(GetSingleUserFailure());
    }
  }
}
