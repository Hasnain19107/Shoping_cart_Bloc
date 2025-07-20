import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:product_cart_app/features/auth/domain/usecases/sign_in.dart';
import 'package:product_cart_app/features/auth/domain/usecases/sign_up.dart';
import 'package:product_cart_app/features/auth/domain/usecases/sign_out.dart';
import 'package:product_cart_app/features/auth/domain/usecases/get_current_user.dart';
import 'package:product_cart_app/features/auth/domain/usecases/check_auth_status.dart';

import 'package:product_cart_app/core/usecases/usecase.dart';
import 'package:product_cart_app/core/error/failures.dart';
import 'package:product_cart_app/features/auth/presentation/bloc/auth_event.dart';
import 'package:product_cart_app/features/auth/presentation/bloc/auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final SignIn signIn;
  final SignUp signUp;
  final SignOut signOut;
  final GetCurrentUser getCurrentUser;
  final CheckAuthStatus checkAuthStatus;

  AuthBloc({
    required this.signIn,
    required this.signUp,
    required this.signOut,
    required this.getCurrentUser,
    required this.checkAuthStatus,
  }) : super(AuthInitial()) {
    on<CheckAuthStatusEvent>(_onCheckAuthStatus);
    on<SignInEvent>(_onSignIn);
    on<SignUpEvent>(_onSignUp);
    on<SignOutEvent>(_onSignOut);
    on<ContinueAsGuestEvent>(_onContinueAsGuest);
  }

  void _onCheckAuthStatus(
    CheckAuthStatusEvent event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());

    try {
      // Check if user is logged in
      final authStatusResult = await checkAuthStatus(NoParams());

      final isLoggedIn = authStatusResult.fold(
        (failure) => false,
        (loggedIn) => loggedIn,
      );

      if (!isLoggedIn) {
        if (!emit.isDone) emit(AuthUnauthenticated());
        return;
      }

      // If logged in, get current user
      final userResult = await getCurrentUser(NoParams());

      userResult.fold(
        (failure) {
          if (!emit.isDone) emit(AuthUnauthenticated());
        },
        (user) {
          if (user != null) {
            if (!emit.isDone) emit(AuthAuthenticated(user: user));
          } else {
            if (!emit.isDone) emit(AuthUnauthenticated());
          }
        },
      );
    } catch (e) {
      if (!emit.isDone) emit(AuthUnauthenticated());
    }
  }

  void _onSignIn(
    SignInEvent event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());

    final result = await signIn(SignInParams(
      email: event.email,
      password: event.password,
    ));

    result.fold(
      (failure) => emit(AuthError(message: _mapFailureToMessage(failure))),
      (user) => emit(AuthAuthenticated(user: user)),
    );
  }

  void _onSignUp(
    SignUpEvent event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());

    final result = await signUp(SignUpParams(
      email: event.email,
      password: event.password,
    ));

    result.fold(
      (failure) => emit(AuthError(message: _mapFailureToMessage(failure))),
      (user) => emit(AuthAuthenticated(user: user)),
    );
  }

  void _onSignOut(
    SignOutEvent event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());

    final result = await signOut(NoParams());

    result.fold(
      (failure) => emit(AuthError(message: _mapFailureToMessage(failure))),
      (success) => emit(AuthUnauthenticated()),
    );
  }

  void _onContinueAsGuest(
    ContinueAsGuestEvent event,
    Emitter<AuthState> emit,
  ) {
    emit(AuthGuest());
  }

  String _mapFailureToMessage(Failure failure) {
    if (failure is ServerFailure) {
      return 'Server failure. Please try again.';
    } else if (failure is CacheFailure) {
      return 'Cache failure. Please try again.';
    } else if (failure is NetworkFailure) {
      return 'Network failure. Please check your connection.';
    } else {
      return 'Unexpected error. Please try again.';
    }
  }
}
