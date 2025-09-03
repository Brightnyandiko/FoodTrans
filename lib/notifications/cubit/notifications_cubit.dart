import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '../models/notification.dart';

part 'notifications_state.dart';

class NotificationsCubit extends Cubit<NotificationsState> {
  NotificationsCubit() : super(const NotificationsState());

  void loadNotifications() {
    emit(state.copyWith(status: NotificationsStatus.loading));

    try {
      final notifications = _getMockNotifications();
      final now = DateTime.now();
      final today = DateTime(now.year, now.month, now.day);
      final yesterday = today.subtract(const Duration(days: 1));

      final todayNotifications = notifications
          .where((notification) =>
      notification.timestamp.isAfter(today) ||
          notification.timestamp.isAtSameMomentAs(today))
          .toList();

      final yesterdayNotifications = notifications
          .where((notification) =>
      notification.timestamp.isAfter(yesterday) &&
          notification.timestamp.isBefore(today))
          .toList();

      emit(
        state.copyWith(
          status: NotificationsStatus.success,
          notifications: notifications,
          todayNotifications: todayNotifications,
          yesterdayNotifications: yesterdayNotifications,
        ),
      );
    } catch (error) {
      emit(state.copyWith(status: NotificationsStatus.failure));
    }
  }

  void markAsRead(String notificationId) {
    final updatedNotifications = state.notifications.map((notification) {
      if (notification.id == notificationId) {
        return notification.copyWith(isRead: true);
      }
      return notification;
    }).toList();

    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final yesterday = today.subtract(const Duration(days: 1));

    final todayNotifications = updatedNotifications
        .where((notification) =>
    notification.timestamp.isAfter(today) ||
        notification.timestamp.isAtSameMomentAs(today))
        .toList();

    final yesterdayNotifications = updatedNotifications
        .where((notification) =>
    notification.timestamp.isAfter(yesterday) &&
        notification.timestamp.isBefore(today))
        .toList();

    emit(
      state.copyWith(
        notifications: updatedNotifications,
        todayNotifications: todayNotifications,
        yesterdayNotifications: yesterdayNotifications,
      ),
    );
  }

  List<NotificationModel> _getMockNotifications() {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final yesterday = today.subtract(const Duration(days: 1));

    return [
      NotificationModel(
        id: '1',
        type: NotificationType.discount,
        title: '30% Special Discount!',
        subtitle: 'Special promotion only valid today',
        timestamp: today.add(const Duration(hours: 10)),
        isRead: false,
      ),
      NotificationModel(
        id: '2',
        type: NotificationType.orderUpdate,
        title: 'Your Order Has Been Taken by the Driver',
        subtitle: 'Recently!',
        timestamp: today.add(const Duration(hours: 9)),
        isRead: false,
      ),
      NotificationModel(
        id: '3',
        type: NotificationType.orderCanceled,
        title: 'Your Order Has Been Canceled',
        subtitle: '19 Jun 2023',
        timestamp: today.add(const Duration(hours: 8)),
        isRead: false,
      ),
      NotificationModel(
        id: '4',
        type: NotificationType.email,
        title: '35% Special Discount!',
        subtitle: 'Special promotion only valid today',
        timestamp: yesterday.add(const Duration(hours: 14)),
        isRead: false,
      ),
      NotificationModel(
        id: '5',
        type: NotificationType.account,
        title: 'Account Setup Successful!',
        subtitle: 'Special promotion only valid today',
        timestamp: yesterday.add(const Duration(hours: 12)),
        isRead: false,
      ),
      NotificationModel(
        id: '6',
        type: NotificationType.discount,
        title: 'Special Offer! 60% Off',
        subtitle: 'Special offer for new account, valid until 20 Nov 2022',
        timestamp: yesterday.add(const Duration(hours: 10)),
        isRead: false,
      ),
      NotificationModel(
        id: '7',
        type: NotificationType.payment,
        title: 'Credit Card Connected',
        subtitle: 'Special promotion only valid today',
        timestamp: yesterday.add(const Duration(hours: 8)),
        isRead: false,
      ),
    ];
  }
}