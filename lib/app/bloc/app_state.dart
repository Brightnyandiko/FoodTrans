// part of 'app_bloc.dart';
//
// enum AppStatus { authenticated, unauthenticated }
//
// final class AppState extends Equatable {
//   const AppState({User user = User.empty})
//       : this._(
//     status: user == User.empty
//         ? AppStatus.unauthenticated
//         : AppStatus.authenticated,
//     user: user,
//   );
//
//   const AppState._({required this.status, this.user = User.empty});
//
//   final AppStatus status;
//   final User user;
//
//   @override
//   List<Object> get props => [status, user];
// }

// lib/app/cubit/app_state.dart
part of 'app_bloc.dart';

enum AppStatus { authenticated, unauthenticated }

final class AppState extends Equatable {
  const AppState({
    User user = User.empty,
    Locale locale = const Locale('en'),
    bool isLoading = true,
  }) : this._(
    status: user == User.empty
        ? AppStatus.unauthenticated
        : AppStatus.authenticated,
    user: user,
    locale: locale,
    isLoading: isLoading,
  );

  const AppState._({
    required this.status,
    this.user = User.empty,
    this.locale = const Locale('en'),
    this.isLoading = true,
  });

  final AppStatus status;
  final User user;
  final Locale locale;
  final bool isLoading;

  AppState copyWith({
    User? user,
    Locale? locale,
    bool? isLoading,
  }) {
    return AppState(
      user: user ?? this.user,
      locale: locale ?? this.locale,
      isLoading: isLoading ?? this.isLoading,
    );
  }

  @override
  List<Object> get props => [status, user, locale, isLoading];
}