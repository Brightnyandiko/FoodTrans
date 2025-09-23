// lib/app/cubit/app_event.dart
part of 'app_bloc.dart';

sealed class AppEvent {
  const AppEvent();
}

final class AppUserSubscriptionRequested extends AppEvent {
  const AppUserSubscriptionRequested();
}

final class AppLogoutPressed extends AppEvent {
  const AppLogoutPressed();
}

// Internal events for settings management
final class _AppUserChanged extends AppEvent {
  const _AppUserChanged(this.user);
  final User user;
}

final class _AppLocaleChanged extends AppEvent {
  const _AppLocaleChanged(this.locale);
  final Locale locale;
}

final class _AppSettingsLoaded extends AppEvent {
  const _AppSettingsLoaded();
}