import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubit/notifications_cubit.dart';
import '../models/notification.dart';

class NotificationsView extends StatelessWidget {
  const NotificationsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text(
          'Notification',
          style: TextStyle(
            color: Colors.black,
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
      ),
      body: BlocBuilder<NotificationsCubit, NotificationsState>(
        builder: (context, state) {
          if (state.status == NotificationsStatus.loading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state.status == NotificationsStatus.failure) {
            return const Center(
              child: Text('Failed to load notifications'),
            );
          }

          return SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (state.todayNotifications.isNotEmpty) ...[
                  const _SectionHeader(title: 'Today'),
                  const SizedBox(height: 16),
                  ...state.todayNotifications.map(
                        (notification) => Padding(
                      padding: const EdgeInsets.only(bottom: 16),
                      child: _NotificationItem(notification: notification),
                    ),
                  ),
                ],
                if (state.yesterdayNotifications.isNotEmpty) ...[
                  const SizedBox(height: 8),
                  const _SectionHeader(title: 'Yesterday'),
                  const SizedBox(height: 16),
                  ...state.yesterdayNotifications.map(
                        (notification) => Padding(
                      padding: const EdgeInsets.only(bottom: 16),
                      child: _NotificationItem(notification: notification),
                    ),
                  ),
                ],
              ],
            ),
          );
        },
      ),
    );
  }
}

class _SectionHeader extends StatelessWidget {
  const _SectionHeader({required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w500,
        color: Colors.grey[600],
      ),
    );
  }
}

class _NotificationItem extends StatelessWidget {
  const _NotificationItem({required this.notification});

  final NotificationModel notification;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.read<NotificationsCubit>().markAsRead(notification.id);
      },
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: notification.isRead ? Colors.grey[50] : Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.grey[200]!),
        ),
        child: Row(
          children: [
            _NotificationIcon(type: notification.type),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    notification.title,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    notification.subtitle,
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey[600],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _NotificationIcon extends StatelessWidget {
  const _NotificationIcon({required this.type});

  final NotificationType type;

  @override
  Widget build(BuildContext context) {
    IconData iconData;
    Color backgroundColor;

    switch (type) {
      case NotificationType.discount:
        iconData = Icons.percent;
        backgroundColor = Colors.red[100]!;
        break;
      case NotificationType.orderUpdate:
        iconData = Icons.check_circle;
        backgroundColor = Colors.green[100]!;
        break;
      case NotificationType.orderCanceled:
        iconData = Icons.cancel;
        backgroundColor = Colors.red[100]!;
        break;
      case NotificationType.email:
        iconData = Icons.email;
        backgroundColor = Colors.grey[100]!;
        break;
      case NotificationType.account:
        iconData = Icons.person;
        backgroundColor = Colors.grey[100]!;
        break;
      case NotificationType.payment:
        iconData = Icons.credit_card;
        backgroundColor = Colors.orange[100]!;
        break;
    }

    return Container(
      width: 40,
      height: 40,
      decoration: BoxDecoration(
        color: backgroundColor,
        shape: BoxShape.circle,
      ),
      child: Icon(
        iconData,
        color: _getIconColor(type),
        size: 20,
      ),
    );
  }

  Color _getIconColor(NotificationType type) {
    switch (type) {
      case NotificationType.discount:
        return Colors.red;
      case NotificationType.orderUpdate:
        return Colors.green;
      case NotificationType.orderCanceled:
        return Colors.red;
      case NotificationType.email:
        return Colors.grey[700]!;
      case NotificationType.account:
        return Colors.grey[700]!;
      case NotificationType.payment:
        return Colors.orange;
    }
  }
}