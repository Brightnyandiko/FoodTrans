// lib/settings/cubit/settings_state.dart
part of 'settings_cubit.dart';

abstract class SettingsState extends Equatable {
  const SettingsState();

  @override
  List<Object> get props => [];
}

class SettingsInitial extends SettingsState {}

class SettingsLoading extends SettingsState {}

class SettingsLoaded extends SettingsState {
  const SettingsLoaded(this.settings);

  final AppSettings settings;

  @override
  List<Object> get props => [settings];
}

class SettingsError extends SettingsState {
  const SettingsError(this.message);

  final String message;

  @override
  List<Object> get props => [message];
}

class PermissionRequesting extends SettingsState {
  const PermissionRequesting(this.settings);

  final AppSettings settings;

  @override
  List<Object> get props => [settings];
}