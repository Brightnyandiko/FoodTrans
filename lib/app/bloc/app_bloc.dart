// import 'dart:async';
//
// import 'package:authentication_repository/authentication_repository.dart';
// import 'package:bloc/bloc.dart';
// import 'package:equatable/equatable.dart';
//
// part 'app_event.dart';
// part 'app_state.dart';
//
// class AppBloc extends Bloc<AppEvent, AppState> {
//   AppBloc({required AuthenticationRepository authenticationRepository})
//       : _authenticationRepository = authenticationRepository,
//         super(AppState(user: authenticationRepository.currentUser)) {
//     on<AppUserSubscriptionRequested>(_onUserSubscriptionRequested);
//     on<AppLogoutPressed>(_onLogoutPressed);
//   }
//
//   final AuthenticationRepository _authenticationRepository;
//
//   Future<void> _onUserSubscriptionRequested(
//       AppUserSubscriptionRequested event,
//       Emitter<AppState> emit,
//       ) {
//     return emit.onEach(
//       _authenticationRepository.user,
//       onData: (user) => emit(AppState(user: user)),
//       onError: addError,
//     );
//   }
//
//   void _onLogoutPressed(
//       AppLogoutPressed event,
//       Emitter<AppState> emit,
//       ) {
//     _authenticationRepository.logOut();
//   }
// }

// lib/app/cubit/app_cubit.dart
import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:authentication_repository/authentication_repository.dart';

import '../../settings/models/app_settings.dart';
import '../../repositories/settings_repository.dart';

part 'app_event.dart';
part 'app_state.dart';

class AppBloc extends Bloc<AppEvent, AppState> {
  AppBloc({
    required AuthenticationRepository authenticationRepository,
    required SettingsRepository settingsRepository,
  })  : _authenticationRepository = authenticationRepository,
        _settingsRepository = settingsRepository,
        super(AppState(user: authenticationRepository.currentUser)) {
    on<AppUserSubscriptionRequested>(_onUserSubscriptionRequested);
    on<AppLogoutPressed>(_onLogoutPressed);
    on<_AppUserChanged>(_onUserChanged);
    on<_AppLocaleChanged>(_onLocaleChanged);
    on<_AppSettingsLoaded>(_onSettingsLoaded);

    // Auto-load settings on initialization
    add(const _AppSettingsLoaded());
  }

  final AuthenticationRepository _authenticationRepository;
  final SettingsRepository _settingsRepository;

  Future<void> _onUserSubscriptionRequested(
      AppUserSubscriptionRequested event,
      Emitter<AppState> emit,
      ) {
    return emit.onEach(
      _authenticationRepository.user,
      onData: (user) => add(_AppUserChanged(user)),
      onError: addError,
    );
  }

  void _onLogoutPressed(
      AppLogoutPressed event,
      Emitter<AppState> emit,
      ) {
    _authenticationRepository.logOut();
  }

  void _onUserChanged(
      _AppUserChanged event,
      Emitter<AppState> emit,
      ) {
    emit(state.copyWith(user: event.user));
  }

  void _onLocaleChanged(
      _AppLocaleChanged event,
      Emitter<AppState> emit,
      ) {
    emit(state.copyWith(locale: event.locale));
  }

  Future<void> _onSettingsLoaded(
      _AppSettingsLoaded event,
      Emitter<AppState> emit,
      ) async {
    try {
      final settings = await _settingsRepository.getSettings();
      emit(state.copyWith(
        locale: settings.language.locale,
        isLoading: false,
      ));
    } catch (error) {
      emit(state.copyWith(isLoading: false));
      addError(error);
    }
  }

  // Public methods for external use (maintaining Cubit-like interface)
  void changeLocale(Locale locale) {
    add(_AppLocaleChanged(locale));
  }

  void requestUserSubscription() {
    add(const AppUserSubscriptionRequested());
  }

  void logOut() {
    add(const AppLogoutPressed());
  }

  Future<void> loadAppSettings() async {
    add(const _AppSettingsLoaded());
  }
}