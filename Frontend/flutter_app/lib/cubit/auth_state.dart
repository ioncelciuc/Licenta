part of 'auth_cubit.dart';

abstract class AuthState {}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}

class AuthCompleted extends AuthState {}

class AuthFailed extends AuthState {
  final Response response;

  AuthFailed(this.response);
}
