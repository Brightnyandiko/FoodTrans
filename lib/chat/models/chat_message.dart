import 'package:equatable/equatable.dart';

class ChatMessage extends Equatable {
  const ChatMessage({
    required this.id,
    required this.senderName,
    required this.senderImage,
    required this.message,
    required this.timestamp,
    required this.unreadCount,
    required this.isRead,
  });

  final String id;
  final String senderName;
  final String senderImage;
  final String message;
  final String timestamp;
  final int unreadCount;
  final bool isRead;

  @override
  List<Object> get props => [
    id,
    senderName,
    senderImage,
    message,
    timestamp,
    unreadCount,
    isRead,
  ];
}