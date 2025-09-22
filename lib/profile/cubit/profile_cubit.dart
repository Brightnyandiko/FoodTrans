// lib/profile/cubit/profile_cubit.dart
import 'dart:io';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:image_picker/image_picker.dart';

import '../../repositories/profile_repository.dart';
import '../../repositories/order_repository.dart';
import '../models/user_profile.dart';
import '../models/order.dart';

part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit({
    required ProfileRepository profileRepository,
    required OrderRepository orderRepository,
  })  : _profileRepository = profileRepository,
        _orderRepository = orderRepository,
        super(ProfileInitial());

  final ProfileRepository _profileRepository;
  final OrderRepository _orderRepository;
  final ImagePicker _imagePicker = ImagePicker();

  Future<void> loadProfile() async {
    emit(ProfileLoading());
    try {
      final user = await _profileRepository.getUserProfile();
      final orders = await _orderRepository.getUserOrders();

      emit(ProfileLoaded(user: user, recentOrders: orders));
    } catch (error) {
      emit(ProfileError('Failed to load profile: ${error.toString()}'));
    }
  }

  Future<void> uploadProfileImage() async {
    final currentState = state;
    if (currentState is! ProfileLoaded) return;

    try {
      final XFile? pickedFile = await _imagePicker.pickImage(
        source: ImageSource.gallery,
        maxWidth: 800,
        maxHeight: 800,
        imageQuality: 85,
      );

      if (pickedFile == null) return;

      emit(ProfileImageUploading(
        user: currentState.user,
        recentOrders: currentState.recentOrders,
      ));

      final imageFile = File(pickedFile.path);
      final imageUrl = await _profileRepository.uploadProfileImage(imageFile);

      final updatedUser = currentState.user.copyWith(
        profileImageUrl: imageUrl,
        hasNotifications: false, // Clear notification after upload
      );

      final updatedProfile = await _profileRepository.updateUserProfile(updatedUser);

      emit(ProfileLoaded(
        user: updatedProfile,
        recentOrders: currentState.recentOrders,
      ));
    } catch (error) {
      emit(ProfileError('Failed to upload image: ${error.toString()}'));

      // Return to previous state after showing error
      if (currentState is ProfileLoaded) {
        emit(currentState);
      }
    }
  }

  Future<void> deleteAccount() async {
    final currentState = state;
    if (currentState is! ProfileLoaded) return;

    emit(AccountDeletionInProgress());

    try {
      await _profileRepository.deleteAccount();
      emit(AccountDeleted());
    } catch (error) {
      emit(ProfileError('Failed to delete account: ${error.toString()}'));

      // Return to previous state
      emit(currentState);
    }
  }

  void clearNotifications() {
    final currentState = state;
    if (currentState is ProfileLoaded && currentState.user.hasNotifications) {
      final updatedUser = currentState.user.copyWith(hasNotifications: false);
      emit(currentState.copyWith(user: updatedUser));
    }
  }
}