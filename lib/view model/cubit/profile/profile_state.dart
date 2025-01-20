part of 'profile_cubit.dart';

sealed class ProfileState extends Equatable {
  const ProfileState();

  @override
  List<Object> get props => [];
}

final class ProfileInitial extends ProfileState {}

final class ProfileSuccess extends ProfileState {
  UserModel userInfo;
  ProfileSuccess({required this.userInfo});
}

final class ProfileUpdateSuccess extends ProfileState {}


final class ProfileError extends ProfileState {
  String errorMessage;
  ProfileError({required this.errorMessage});
}

final class ProfileLoading extends ProfileState {}
