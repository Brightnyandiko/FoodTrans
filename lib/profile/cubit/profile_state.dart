// lib/profile/cubit/profile_state.dart
part of 'profile_cubit.dart';

abstract class ProfileState extends Equatable {
  const ProfileState();

  @override
  List<Object?> get props => [];
}

class ProfileInitial extends ProfileState {}

class ProfileLoading extends ProfileState {}

class ProfileLoaded extends ProfileState {
  const ProfileLoaded({
    required this.user,
    required this.recentOrders,
  });

  final UserProfile user;
  final List<Order> recentOrders;

  ProfileLoaded copyWith({
    UserProfile? user,
    List<Order>? recentOrders,
  }) {
    return ProfileLoaded(
      user: user ?? this.user,
      recentOrders: recentOrders ?? this.recentOrders,
    );
  }

  @override
  List<Object> get props => [user, recentOrders];
}

class ProfileImageUploading extends ProfileState {
  const ProfileImageUploading({
    required this.user,
    required this.recentOrders,
  });

  final UserProfile user;
  final List<Order> recentOrders;

  @override
  List<Object> get props => [user, recentOrders];
}

class ProfileError extends ProfileState {
  const ProfileError(this.message);

  final String message;

  @override
  List<Object> get props => [message];
}

class AccountDeletionInProgress extends ProfileState {}

class AccountDeleted extends ProfileState {}