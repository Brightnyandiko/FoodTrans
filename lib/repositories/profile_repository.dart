// lib/repositories/profile_repository.dart
import 'dart:io';
import '../profile/models/user_profile.dart';

class ProfileRepository {
  // Simulate API calls with delays

  Future<UserProfile> getUserProfile() async {
    await Future.delayed(const Duration(milliseconds: 500));
    return const UserProfile(
      id: '123',
      name: 'Albert Stevano Bajefski',
      email: 'Albertstevano@gmail.com',
      hasNotifications: true,
    );
  }

  Future<String> uploadProfileImage(File imageFile) async {
    // Simulate image upload to cloud storage
    await Future.delayed(const Duration(seconds: 2));

    // In real app, this would upload to Firebase Storage, AWS S3, etc.
    // Return the uploaded image URL
    return 'https://example.com/uploads/${DateTime.now().millisecondsSinceEpoch}.jpg';
  }

  Future<UserProfile> updateUserProfile(UserProfile profile) async {
    await Future.delayed(const Duration(milliseconds: 500));
    return profile;
  }

  Future<void> deleteAccount() async {
    await Future.delayed(const Duration(seconds: 1));
    // Simulate account deletion
  }
}