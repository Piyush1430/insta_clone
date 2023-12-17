import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:insta_clone/features/domain/entities/user/user_entity.dart';
import 'package:insta_clone/features/domain/usecases/firebase_usecases/user/sign_in_usecase.dart';
import 'package:insta_clone/features/domain/usecases/firebase_usecases/user/sign_up_usercases.dart';

part 'credentials_event.dart';
part 'credentials_state.dart';

class CredentialsBloc extends Bloc<CredentialsEvent, CredentialsState> {
  final SignInUseCase signInUseCase;
  final SignUpUseCase signUpUseCase;
  CredentialsBloc({
    required this.signInUseCase,
    required this.signUpUseCase,
  }) : super(CredentialsInitial()) {
    on<SignInUser>(_onSignInUser);
    on<SignUpUser>(_onSignUpUser);
  }

  Future<void> _onSignInUser(
    SignInUser event,
    Emitter<CredentialsState> emit,
  ) async {
    emit(CredentialLoading());
    try {
      await signInUseCase.call(
        UserEntity(email: event.email, password: event.password),
      );
      emit(CredentialSuccess());
    } on SocketException catch (_) {
      emit(CredentialFailure());
    } catch (_) {
      emit(CredentialFailure());
    }
  }

  Future<void> _onSignUpUser(
    SignUpUser event,
    Emitter<CredentialsState> emit,
  ) async {
    emit(CredentialLoading());
    try {
      await signUpUseCase.call(event.user);
      emit(CredentialSuccess());
    } on SocketException catch (_) {
      emit(CredentialFailure());
    } catch (_) {
      emit(CredentialFailure());
    }
  }
}
