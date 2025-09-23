// lib/settings/cubit/settings_cubit.dart
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

import '../../repositories/settings_repository.dart';
import '../models/app_settings.dart';

part 'settings_state.dart';

class SettingsCubit extends Cubit<SettingsState> {
  SettingsCubit({
    required SettingsRepository settingsRepository,
  })  : _settingsRepository = settingsRepository,
        super(SettingsInitial());

  final SettingsRepository _settingsRepository;

  Future<void> loadSettings() async {
    emit(SettingsLoading());
    try {
      final settings = await _settingsRepository.getSettings();

      // Verify permissions match stored settings
      final actualNotificationStatus = await _settingsRepository.getNotificationPermissionStatus();
      final actualLocationStatus = await _settingsRepository.getLocationPermissionStatus();

      // Update settings if permissions have changed externally
      final updatedSettings = settings.copyWith(
        pushNotificationsEnabled: actualNotificationStatus,
        locationEnabled: actualLocationStatus,
      );

      if (updatedSettings != settings) {
        await _settingsRepository.saveSettings(updatedSettings);
      }

      emit(SettingsLoaded(updatedSettings));
    } catch (error) {
      emit(SettingsError('Failed to load settings: ${error.toString()}'));
    }
  }

  Future<void> togglePushNotifications(bool enabled) async {
    final currentState = state;
    if (currentState is! SettingsLoaded) return;

    if (enabled) {
      // Request permission if enabling
      emit(PermissionRequesting(currentState.settings));

      final granted = await _settingsRepository.requestNotificationPermission();

      if (granted) {
        final updatedSettings = currentState.settings.copyWith(
          pushNotificationsEnabled: true,
        );

        await _settingsRepository.saveSettings(updatedSettings);
        emit(SettingsLoaded(updatedSettings));
      } else {
        // Permission denied, revert to loaded state
        emit(SettingsLoaded(currentState.settings));
        // Optionally show dialog to open app settings
      }
    } else {
      // Disable notifications
      final updatedSettings = currentState.settings.copyWith(
        pushNotificationsEnabled: false,
      );

      await _settingsRepository.saveSettings(updatedSettings);
      emit(SettingsLoaded(updatedSettings));
    }
  }

  Future<void> toggleLocation(bool enabled) async {
    final currentState = state;
    if (currentState is! SettingsLoaded) return;

    if (enabled) {
      emit(PermissionRequesting(currentState.settings));

      final granted = await _settingsRepository.requestLocationPermission();

      if (granted) {
        final updatedSettings = currentState.settings.copyWith(
          locationEnabled: true,
        );

        await _settingsRepository.saveSettings(updatedSettings);
        emit(SettingsLoaded(updatedSettings));
      } else {
        emit(SettingsLoaded(currentState.settings));
      }
    } else {
      final updatedSettings = currentState.settings.copyWith(
        locationEnabled: false,
      );

      await _settingsRepository.saveSettings(updatedSettings);
      emit(SettingsLoaded(updatedSettings));
    }
  }

  Future<void> changeLanguage(AppLanguage language) async {
    final currentState = state;
    if (currentState is! SettingsLoaded) return;

    try {
      final updatedSettings = currentState.settings.copyWith(language: language);
      await _settingsRepository.saveSettings(updatedSettings);
      emit(SettingsLoaded(updatedSettings));
    } catch (error) {
      emit(SettingsError('Failed to change language: ${error.toString()}'));
    }
  }
}