// lib/profile/models/user_profile.dart
import 'package:equatable/equatable.dart';

class UserProfile extends Equatable {
  const UserProfile({
    required this.id,
    required this.name,
    required this.email,
    this.profileImageUrl,
    this.hasNotifications = false,
  });

  final String id;
  final String name;
  final String email;
  final String? profileImageUrl;
  final bool hasNotifications;

  UserProfile copyWith({
    String? id,
    String? name,
    String? email,
    String? profileImageUrl,
    bool? hasNotifications,
  }) {
    return UserProfile(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      profileImageUrl: profileImageUrl ?? this.profileImageUrl,
      hasNotifications: hasNotifications ?? this.hasNotifications,
    );
  }

  @override
  List<Object?> get props => [id, name, email, profileImageUrl, hasNotifications];
}