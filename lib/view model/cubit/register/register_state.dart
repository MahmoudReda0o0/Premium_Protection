part of 'register_cubit.dart';

sealed class RegisterState extends Equatable {
  const RegisterState();

  @override
  List<Object> get props => [];
}

final class RegisterInitial extends RegisterState {}

final class RegisterError extends RegisterState {
  String errorMessage;

  RegisterError({required this.errorMessage});
}

final class RegisterSuccess extends RegisterState {
  String token;

  RegisterSuccess({required this.token});
}

final class RegisterLoading extends RegisterState {}
