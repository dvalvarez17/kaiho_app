import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kaiho_app/features/auth/domain/entities/user_entity.dart';
import 'package:kaiho_app/features/auth/presentation/bloc/auth_event.dart';
import 'package:kaiho_app/features/auth/presentation/bloc/auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthInitial()) {
    on<LoginRequested>(_onLoginRequested);
    on<RegisterRequested>(_onRegisterRequested);
    on<GoogleSignInRequested>(_onGoogleSignInRequested);
    on<LogoutRequested>(_onLogoutRequested);
  }

  Future<void> _onLoginRequested(
    LoginRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());
    try {
      // TODO: Implementar integración con Firebase Auth
      await Future.delayed(const Duration(seconds: 2));

      // Mock user para desarrollo
      const user = UserEntity(
        id: '1',
        email: 'user@example.com',
        name: 'Usuario Demo',
      );

      emit(const AuthAuthenticated(user));
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }

  Future<void> _onRegisterRequested(
    RegisterRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());
    try {
      // TODO: Implementar integración con Firebase Auth
      await Future.delayed(const Duration(seconds: 2));

      final user = UserEntity(
        id: '1',
        email: event.email,
        name: event.name,
      );

      emit(AuthAuthenticated(user));
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }

  Future<void> _onGoogleSignInRequested(
    GoogleSignInRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());
    try {
      // TODO: Implementar integración con Google Sign-In
      await Future.delayed(const Duration(seconds: 2));

      const user = UserEntity(
        id: '1',
        email: 'user@gmail.com',
        name: 'Usuario Google',
      );

      emit(const AuthAuthenticated(user));
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }

  Future<void> _onLogoutRequested(
    LogoutRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());
    try {
      // TODO: Implementar cierre de sesión con Firebase
      await Future.delayed(const Duration(seconds: 1));
      emit(AuthUnauthenticated());
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }
}