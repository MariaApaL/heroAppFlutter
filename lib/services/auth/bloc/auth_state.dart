import 'package:flutter/foundation.dart' show immutable;
import 'package:heroapp/services/auth/auth_user.dart';
import 'package:equatable/equatable.dart';

import '../../api/models/superhero_api_model.dart';

@immutable
abstract class AuthState {
  final bool isLoading;
  final String? loadingText;
  const AuthState({
    required this.isLoading,
    this.loadingText = 'Please wait a moment',
  });
}

class AuthStateUninitialized extends AuthState {
  const AuthStateUninitialized({required bool isLoading})
      : super(isLoading: isLoading);
}

class AuthStateRegistering extends AuthState {
  final Exception? exception;
  const AuthStateRegistering({
    required this.exception,
    required isLoading,
  }) : super(isLoading: isLoading);
}

class AuthStateForgotPassword extends AuthState {
  final Exception? exception;
  final bool hasSentEmail;
  const AuthStateForgotPassword({
    required this.exception,
    required this.hasSentEmail,
    required bool isLoading,
  }) : super(isLoading: isLoading);
}

class AuthStateLoggedIn extends AuthState {
  final AuthUser user;
  const AuthStateLoggedIn({
    required this.user,
    required bool isLoading,
  }) : super(isLoading: isLoading);
}

class AuthStateNeedsVerification extends AuthState {
  const AuthStateNeedsVerification({required bool isLoading})
      : super(isLoading: isLoading);
}

class AuthStateLoggedOut extends AuthState with EquatableMixin {
  final Exception? exception;
  const AuthStateLoggedOut({
    required this.exception,
    required bool isLoading,
    String? loadingText,
  }) : super(
          isLoading: isLoading,
          loadingText: loadingText,
        );


        

  @override
  List<Object?> get props => [exception, isLoading];
}

// class AuthStateSearchLoading extends AuthState {
//   const AuthStateSearchLoading({required bool isLoading})
//       : super(
//         isLoading: isLoading
          
//         );
// }

// class AuthStateSearchSuccess extends AuthState {
//   final List<SuperheroResponse> superheroes;

//   const AuthStateSearchSuccess({
//     required this.superheroes,
//     required bool isLoading,
//   }) : super(isLoading: isLoading);
// }

// class AuthStateSearchError extends AuthState{
//   final Exception? exception;
//   const AuthStateSearchError({
//     required this.exception,
//     required bool isLoading,
//   }) : super(isLoading: isLoading);
// }