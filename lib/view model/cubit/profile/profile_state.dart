part of 'profile_cubit.dart';

sealed class ProfileState extends Equatable {
  const ProfileState();

  @override
  List<Object> get props => [];
}

final class ProfileInitial extends ProfileState {}

final class ProfileSuccess extends ProfileState {
  LocalUser localUser;
  ProfileSuccess({required this.localUser});
}

final class ProfileError extends ProfileState {}

final class ProfileLoading extends ProfileState {}
