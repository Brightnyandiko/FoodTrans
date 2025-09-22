// lib/profile/models/user_profile.dart
import 'package:equatable/equatable.dart';

class UserProfile extends Equatable {
  const UserProfile({
    required this.id,
    required this.name,
    required this.email,
    this.profileImageUrl,
    this.hasNotifications = false,
    this.dateOfBirth,
    this.gender,
    this.phoneNumber,
  });

  final String id;
  final String name;
  final String email;
  final String? profileImageUrl;
  final bool hasNotifications;
  final DateTime? dateOfBirth;
  final String? gender;
  final String? phoneNumber;

  UserProfile copyWith({
    String? id,
    String? name,
    String? email,
    String? profileImageUrl,
    bool? hasNotifications,
    DateTime? dateOfBirth,
    String? gender,
    String? phoneNumber,
  }) {
    return UserProfile(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      profileImageUrl: profileImageUrl ?? this.profileImageUrl,
      hasNotifications: hasNotifications ?? this.hasNotifications,
      dateOfBirth: dateOfBirth ?? this.dateOfBirth,
      gender: gender ?? this.gender,
      phoneNumber: phoneNumber ?? this.phoneNumber,
    );
  }

  @override
  List<Object?> get props => [
    id,
    name,
    email,
    profileImageUrl,
    hasNotifications,
    dateOfBirth,
    gender,
    phoneNumber,
  ];
}