import '../models/chat_message.dart';

class ChatRepository {
  // Simulating API call with mock data matching the design
  Future<List<ChatMessage>> getMessages() async {
    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 500));

    return [
      const ChatMessage(
        id: '1',
        senderName: 'Geopart Etdsien',
        senderImage: 'assets/images/geopart.jpg',
        message: 'Your Order Just Arrived!',
        timestamp: '13.47',
        unreadCount: 0,
        isRead: true,
      ),
      const ChatMessage(
        id: '2',
        senderName: 'Stevano Clirover',
        senderImage: 'assets/images/stevano.jpg',
        message: 'Your Order Just Arrived!',
        timestamp: '11.23',
        unreadCount: 3,
        isRead: false,
      ),
      const ChatMessage(
        id: '3',
        senderName: 'Elisia Justin',
        senderImage: 'assets/images/elisia.jpg',
        message: 'Your Order Just Arrived!',
        timestamp: '11.23',
        unreadCount: 0,
        isRead: true,
      ),
      const ChatMessage(
        id: '4',
        senderName: 'Geopart Etdsien',
        senderImage: 'assets/images/geopart.jpg',
        message: 'Your Order Just Arrived!',
        timestamp: '13.47',
        unreadCount: 0,
        isRead: true,
      ),
      const ChatMessage(
        id: '5',
        senderName: 'Stevano Clirover',
        senderImage: 'assets/images/stevano.jpg',
        message: 'Your Order Just Arrived!',
        timestamp: '11.23',
        unreadCount: 3,
        isRead: false,
      ),
      const ChatMessage(
        id: '6',
        senderName: 'Elisia Justin',
        senderImage: 'assets/images/elisia.jpg',
        message: 'Your Order Just Arrived!',
        timestamp: '11.23',
        unreadCount: 0,
        isRead: true,
      ),
    ];
  }
}