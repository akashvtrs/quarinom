import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart'; // Required for TextEditingController
import 'package:quarinom/core/api/apiservice.dart';
import 'package:quarinom/core/models/chat.dart';
import 'package:quarinom/core/models/message.dart';

class ChatState {}

class ChatInitial extends ChatState {}

class ChatLoading extends ChatState {}

class ChatLoaded extends ChatState {
  final List<ViewChat> chats;

  ChatLoaded(this.chats);
}
class ChatHistoryLoaded extends ChatState {
  final List<ViewHistory> messages; // Generic list to handle chat messages
  ChatHistoryLoaded(this.messages);
}
class ChatFailure extends ChatState {
  final String error;

  ChatFailure(this.error);
}
class FetchChatHistoryEvent extends ChatEvent {
  final String chatId;

  FetchChatHistoryEvent(this.chatId);
} 
class ChatEvent {}

class FetchChats extends ChatEvent {
  final String userId;

  FetchChats(this.userId);
}

class SendMessage extends ChatEvent {
  final String chatId;
  final String senderId;
  final String content;

  SendMessage({
    required this.chatId,
    required this.senderId,
    required this.content,
  });
}


class ChatBloc extends Bloc<ChatEvent, ChatState> {
  final ApiService apiService;
  final TextEditingController messageController = TextEditingController();

  ChatBloc(this.apiService) : super(ChatInitial()) {
    on<FetchChats>(_onFetchChats);
    on<SendMessage>(_onSendMessage);
    on<FetchChatHistoryEvent>(_onFetchChatHistory); // Register handler
  }

  Future<void> _onFetchChatHistory(FetchChatHistoryEvent event, Emitter<ChatState> emit) async {
    emit(ChatLoading());
    try {
      final messages = await apiService.getChatMessages(event.chatId);
      emit(ChatHistoryLoaded(messages));
    } catch (e) {
      emit(ChatFailure(e.toString()));
    }
  }

  Future<void> _onFetchChats(FetchChats event, Emitter<ChatState> emit) async {
    emit(ChatLoading());
    try {
      final chats = await apiService.getUserChats(event.userId);
      emit(ChatLoaded(chats));
    } catch (e) {
      emit(ChatFailure(e.toString()));
    }
  }

  Future<void> _onSendMessage(SendMessage event, Emitter<ChatState> emit) async {
  try {
    await apiService.sendMessage(
      event.chatId,
      event.senderId,
      event.content,
    ); 
    add(FetchChatHistoryEvent(event.chatId));
  } catch (e) {
    emit(ChatFailure(e.toString()));
 
}

  }

  @override
  Future<void> close() {
    messageController.dispose();
    return super.close();
  }
}
