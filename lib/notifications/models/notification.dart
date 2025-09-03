import 'package:equatable/equatable.dart';

enum NotificationType {
  discount,
  orderUpdate,
  orderCanceled,
  email,
  account,
  payment,
}

class NotificationModel extends Equatable {
  const NotificationModel({
    required this.id,
    required this.type,
    required this.title,
    required this.subtitle,
    required this.timestamp,
    required this.isRead,
  });

  final String id;
  final NotificationType type;
  final String title;
  final String subtitle;
  final DateTime timestamp;
  final bool isRead;

  NotificationModel copyWith({
    String? id,
    NotificationType? type,
    String? title,
    String? subtitle,
    DateTime? timestamp,
    bool? isRead,
  }) {
    return NotificationModel(
      id: id ?? this.id,
      type: type ?? this.type,
      title: title ?? this.title,
      subtitle: subtitle ?? this.subtitle,
      timestamp: timestamp ?? this.timestamp,
      isRead: isRead ?? this.isRead,
    );
  }

  @override
  List<Object> get props => [id, type, title, subtitle, timestamp, isRead];
}