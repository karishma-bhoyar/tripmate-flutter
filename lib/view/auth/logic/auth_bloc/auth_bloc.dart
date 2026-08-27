import 'package:flutter_application_tripmate/view/auth/domain/repositories/auth_repository.dart';
import 'package:flutter_application_tripmate/view/auth/logic/auth_bloc/auth_event.dart';
import 'package:flutter_application_tripmate/view/auth/logic/auth_bloc/auth_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository repository;

  AuthBloc({required this.repository}) : super(AuthInitial()) {
    on<AuthCheckRequestedEvent>((event, emit) {
      final user = repository.currentUser;
      if (user != null) {
        emit(Authenticated(user));
      } else {
        emit(Unauthenticated());
      }
    });

    on<AuthLoginRequestedEvent>((event, emit) async {
      emit(AuthLoading());
      try {
        final credential = await repository.login(event.email, event.password);
        if (credential.user != null) {
          emit(Authenticated(credential.user!));
        } else {
          emit(const AuthError('Login failed. Please try again.'));
        }
      } catch (e) {
        emit(AuthError(e.toString()));
      }
    });

    on<AuthSignUpRequestedEvent>((event, emit) async {
      emit(AuthLoading());
      try {
        final credential = await repository.signUp(
          name: event.name,
          email: event.email,
          password: event.password,
        );
        if (credential.user != null) {
          emit(Authenticated(credential.user!));
        } else {
          emit(const AuthError('Sign up failed. Please try again.'));
        }
      } catch (e) {
        emit(AuthError(e.toString()));
      }
    });

    on<AuthLogoutRequestedEvent>((event, emit) async {
      emit(AuthLoading());
      try {
        await repository.logOut();
        emit(Unauthenticated());
      } catch (e) {
        emit(AuthError(e.toString()));
      }
    });
  }
}
