// lib/personal_data/cubit/personal_data_cubit.dart
import 'dart:io';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:image_picker/image_picker.dart';

import '../../../repositories/profile_repository.dart';
import '../../models/user_profile.dart';

// import '../../repositories/profile_repository.dart';
// import '../../profile/models/user_profile.dart';

part 'personal_data_state.dart';

class PersonalDataCubit extends Cubit<PersonalDataState> {
  PersonalDataCubit({
    required ProfileRepository profileRepository,
    required UserProfile initialUser,
  })  : _profileRepository = profileRepository,
        _initialUser = initialUser,
        super(PersonalDataLoaded(user: initialUser));

  final ProfileRepository _profileRepository;
  final UserProfile _initialUser;
  final ImagePicker _imagePicker = ImagePicker();

  void updateName(String name) {
    final currentState = state;
    if (currentState is PersonalDataLoaded) {
      final updatedUser = currentState.user.copyWith(name: name);
      emit(currentState.copyWith(
        user: updatedUser,
        isEdited: _hasChanges(updatedUser),
      ));
    }
  }

  void updateEmail(String email) {
    final currentState = state;
    if (currentState is PersonalDataLoaded) {
      final updatedUser = currentState.user.copyWith(email: email);
      emit(currentState.copyWith(
        user: updatedUser,
        isEdited: _hasChanges(updatedUser),
      ));
    }
  }

  void updatePhoneNumber(String phoneNumber) {
    final currentState = state;
    if (currentState is PersonalDataLoaded) {
      final updatedUser = currentState.user.copyWith(phoneNumber: phoneNumber);
      emit(currentState.copyWith(
        user: updatedUser,
        isEdited: _hasChanges(updatedUser),
      ));
    }
  }

  void updateDateOfBirth(DateTime dateOfBirth) {
    final currentState = state;
    if (currentState is PersonalDataLoaded) {
      final updatedUser = currentState.user.copyWith(dateOfBirth: dateOfBirth);
      emit(currentState.copyWith(
        user: updatedUser,
        isEdited: _hasChanges(updatedUser),
      ));
    }
  }

  void updateGender(String gender) {
    final currentState = state;
    if (currentState is PersonalDataLoaded) {
      final updatedUser = currentState.user.copyWith(gender: gender);
      emit(currentState.copyWith(
        user: updatedUser,
        isEdited: _hasChanges(updatedUser),
      ));
    }
  }

  Future<void> uploadProfileImage() async {
    final currentState = state;
    if (currentState is! PersonalDataLoaded) return;

    try {
      final XFile? pickedFile = await _imagePicker.pickImage(
        source: ImageSource.gallery,
        maxWidth: 800,
        maxHeight: 800,
        imageQuality: 85,
      );

      if (pickedFile == null) return;

      emit(PersonalDataImageUploading(currentState.user));

      final imageFile = File(pickedFile.path);
      final imageUrl = await _profileRepository.uploadProfileImage(imageFile);

      final updatedUser = currentState.user.copyWith(
        profileImageUrl: imageUrl,
        hasNotifications: false,
      );

      emit(PersonalDataLoaded(
        user: updatedUser,
        isEdited: _hasChanges(updatedUser),
      ));
    } catch (error) {
      emit(PersonalDataError('Failed to upload image: ${error.toString()}'));
      emit(currentState);
    }
  }

  Future<void> savePersonalData() async {
    final currentState = state;
    if (currentState is! PersonalDataLoaded) return;

    emit(PersonalDataSaving(currentState.user));

    try {
      final updatedUser = await _profileRepository.updateUserProfile(currentState.user);
      emit(PersonalDataSaved(updatedUser));
    } catch (error) {
      emit(PersonalDataError('Failed to save personal data: ${error.toString()}'));
      emit(currentState);
    }
  }

  bool _hasChanges(UserProfile user) {
    return user.name != _initialUser.name ||
        user.email != _initialUser.email ||
        user.phoneNumber != _initialUser.phoneNumber ||
        user.dateOfBirth != _initialUser.dateOfBirth ||
        user.gender != _initialUser.gender ||
        user.profileImageUrl != _initialUser.profileImageUrl;
  }
}