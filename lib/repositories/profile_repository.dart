// lib/repositories/profile_repository.dart (Updated)
import 'dart:io';
import '../profile/models/user_profile.dart';

class ProfileRepository {
  Future<UserProfile> getUserProfile() async {
    await Future.delayed(const Duration(milliseconds: 500));
    return UserProfile(
      id: '123',
      name: 'Albert Stevano Bajefski',
      email: 'albertstevano@gmail.com',
      hasNotifications: true,
      dateOfBirth: DateTime(1999, 6, 19),
      gender: 'Male',
      phoneNumber: '+1 325-433-7656',
    );
  }

  Future<String> uploadProfileImage(File imageFile) async {
    await Future.delayed(const Duration(seconds: 2));
    return 'https://example.com/uploads/${DateTime.now().millisecondsSinceEpoch}.jpg';
  }

  Future<UserProfile> updateUserProfile(UserProfile profile) async {
    await Future.delayed(const Duration(milliseconds: 800));
    // Simulate API call to update user profile
    return profile;
  }

  Future<void> deleteAccount() async {
    await Future.delayed(const Duration(seconds: 1));
  }
}