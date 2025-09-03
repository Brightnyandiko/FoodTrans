part of 'notifications_cubit.dart';

enum NotificationsStatus { initial, loading, success, failure }

final class NotificationsState extends Equatable {
  const NotificationsState({
    this.status = NotificationsStatus.initial,
    this.notifications = const <NotificationModel>[],
    this.todayNotifications = const <NotificationModel>[],
    this.yesterdayNotifications = const <NotificationModel>[],
  });

  final NotificationsStatus status;
  final List<NotificationModel> notifications;
  final List<NotificationModel> todayNotifications;
  final List<NotificationModel> yesterdayNotifications;

  NotificationsState copyWith({
    NotificationsStatus? status,
    List<NotificationModel>? notifications,
    List<NotificationModel>? todayNotifications,
    List<NotificationModel>? yesterdayNotifications,
  }) {
    return NotificationsState(
      status: status ?? this.status,
      notifications: notifications ?? this.notifications,
      todayNotifications: todayNotifications ?? this.todayNotifications,
      yesterdayNotifications: yesterdayNotifications ?? this.yesterdayNotifications,
    );
  }

  @override
  List<Object> get props => [
    status,
    notifications,
    todayNotifications,
    yesterdayNotifications,
  ];
}