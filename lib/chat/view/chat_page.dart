import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/chat_cubit.dart';
import '../repository/chat_repository.dart';
import 'chat_view.dart';

// This wrapper is used in the main navigation
class ChatPageWrapper extends StatelessWidget {
  const ChatPageWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ChatCubit(
        chatRepository: ChatRepository(),
      )..loadChats(),
      child: const ChatView(),
    );
  }
}

// Keep this for when you need to navigate to chat from other places
class ChatPage extends StatelessWidget {
  const ChatPage({super.key});

  static Route<void> route() {
    return MaterialPageRoute<void>(
      builder: (_) => const ChatPageWrapper(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return const ChatPageWrapper();
  }
}