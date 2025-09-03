import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

import '../models/chat_message.dart';
import '../repository/chat_repository.dart';

part 'chat_state.dart';

class ChatCubit extends Cubit<ChatState> {
  ChatCubit({required ChatRepository chatRepository})
      : _chatRepository = chatRepository,
        super(ChatInitial());

  final ChatRepository _chatRepository;

  Future<void> loadChats() async {
    try {
      emit(ChatLoading());
      final messages = await _chatRepository.getMessages();
      emit(ChatLoaded(messages));
    } catch (error) {
      emit(ChatError(error.toString()));
    }
  }

  Future<void> refreshChats() async {
    await loadChats();
  }
}