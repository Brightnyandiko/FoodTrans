// lib/settings/models/app_settings.dart
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

enum AppLanguage {
  english('en', 'English'),
  spanish('es', 'Spanish'),
  french('fr', 'French');

  const AppLanguage(this.code, this.displayName);
  final String code;
  final String displayName;

  Locale get locale => Locale(code);
}

class AppSettings extends Equatable {
  const AppSettings({
    this.pushNotificationsEnabled = false,
    this.locationEnabled = true,
    this.language = AppLanguage.english,
  });

  final bool pushNotificationsEnabled;
  final bool locationEnabled;
  final AppLanguage language;

  AppSettings copyWith({
    bool? pushNotificationsEnabled,
    bool? locationEnabled,
    AppLanguage? language,
  }) {
    return AppSettings(
      pushNotificationsEnabled: pushNotificationsEnabled ?? this.pushNotificationsEnabled,
      locationEnabled: locationEnabled ?? this.locationEnabled,
      language: language ?? this.language,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'pushNotificationsEnabled': pushNotificationsEnabled,
      'locationEnabled': locationEnabled,
      'language': language.code,
    };
  }

  factory AppSettings.fromJson(Map<String, dynamic> json) {
    return AppSettings(
      pushNotificationsEnabled: json['pushNotificationsEnabled'] ?? false,
      locationEnabled: json['locationEnabled'] ?? true,
      language: AppLanguage.values.firstWhere(
            (lang) => lang.code == json['language'],
        orElse: () => AppLanguage.english,
      ),
    );
  }

  @override
  List<Object> get props => [pushNotificationsEnabled, locationEnabled, language];
}