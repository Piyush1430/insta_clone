// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:insta_clone/features/domain/usecases/firebase_usecases/user/get_current_uid_usecase.dart';
import 'package:insta_clone/features/domain/usecases/firebase_usecases/user/is_log_in_usercase.dart';
import 'package:insta_clone/features/domain/usecases/firebase_usecases/user/is_log_out_usercases.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final IsLogInUseCases isLogInUseCase;
  final IsLogOutUseCase isLogOutUseCase;
  final GetCurrentUidUsecase getCurrentUidUsecase;

  AuthBloc({
    required this.isLogInUseCase,
    required this.isLogOutUseCase,
    required this.getCurrentUidUsecase,
  }) : super(AuthInitial()) {
    on<AppStarted>(_onAppStarted);
    on<LogIn>(_loggedIn);
    on<LogOut>(_logOut);

  }
  Future<void> _onAppStarted(
    AppStarted event,
    Emitter<AuthState> emit,
  ) async {
    try {
      bool isLogIn = await isLogInUseCase.call();
      if (isLogIn == true) {
        final uid = await getCurrentUidUsecase.call();
        emit(Authenticated(uid: uid));
      } else {
        emit(UnAuthenticated());
      }
    } catch (_) {
      emit(UnAuthenticated());
    }
  }

  Future<void> _loggedIn(
    LogIn event,
    Emitter<AuthState> emit,
  ) async {
    try {
      final uid = await getCurrentUidUsecase.call();
      emit(Authenticated(uid: uid));
    } catch (_) {
      emit(UnAuthenticated());
    }
  }

  Future<void> _logOut(
    LogOut event,
    Emitter<AuthState> emit,
  ) async {
    try {
      await isLogOutUseCase.call();
    } catch (_) {
      emit(UnAuthenticated());
    }
  }
}
