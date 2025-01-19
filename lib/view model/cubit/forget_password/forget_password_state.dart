part of 'forget_password_cubit.dart';

sealed class ForgetPasswordState extends Equatable {
  const ForgetPasswordState();

  @override
  List<Object> get props => [];
}

final class ForgetPasswordInitial extends ForgetPasswordState {}

final class ForgetPasswordLoading extends ForgetPasswordState {}

final class ForgetPasswordError extends ForgetPasswordState {
  final String errorMessage;
  const ForgetPasswordError({required this.errorMessage});
}

final class ForgetPasswordSuccess extends ForgetPasswordState {}
