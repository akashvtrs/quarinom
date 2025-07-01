import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:quarinom/core/api/apiservice.dart';
import 'package:quarinom/presentation/bloc/chatbloc.dart';

class HistoryScreen extends StatefulWidget {
  final String chatName;
  final String phonono;
  final String chatId;
  final String userId;

  const HistoryScreen({
    super.key,
    required this.chatName,
    required this.phonono,
    required this.chatId,
    required this.userId,
  });

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  final ScrollController _scrollController = ScrollController();

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  String _formatTime(String? dateTime) {
    if (dateTime == null) return 'Unknown';
    try {
      final parsedDate = DateTime.parse(dateTime);
      return DateFormat('hh:mm a').format(parsedDate); // e.g., "02:30 PM"
    } catch (e) {
      return 'Invalid date';
    }
  }

  void _scrollToBottom() {
    if (_scrollController.hasClients) {
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      appBar: AppBar(
        
        title: Row(
          children: [
            CircleAvatar(
              backgroundColor: Colors.white30,
              child: Text(
                widget.chatName[0].toUpperCase(),
                style: const TextStyle(color: Colors.deepPurple),
              ),
            ),
            const SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.chatName,
                  style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 2),
                Text(
                  widget.phonono,
                  style: const TextStyle(fontSize: 14, color: Colors.white70),
                ),
              ],
            ),
          ],
        ),
        backgroundColor: Colors.deepPurple,
      ),
      body: BlocProvider(
        create: (context) =>
            ChatBloc(ApiService())..add(FetchChatHistoryEvent(widget.chatId)),
        child: BlocBuilder<ChatBloc, ChatState>(
          builder: (context, state) {
            if (state is ChatLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is ChatHistoryLoaded) {
              final messages = state.messages;
              WidgetsBinding.instance.addPostFrameCallback((_) => _scrollToBottom());

              return Column(
                children: [
                  Expanded(
                    child: messages.isNotEmpty
                        ? ListView.builder(
                            controller: _scrollController,
                            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                            itemCount: messages.length,
                            itemBuilder: (context, index) {
                              final message = messages[index];
                              final isCurrentUser = message.senderId == widget.userId;
                              return Align(
                                alignment: isCurrentUser
                                    ? Alignment.centerRight
                                    : Alignment.centerLeft,
                                child: Container(
                                  margin: const EdgeInsets.symmetric(vertical: 4),
                                  padding: const EdgeInsets.all(12),
                                  constraints: const BoxConstraints(maxWidth: 250),
                                  decoration: BoxDecoration(
                                    color: isCurrentUser
                                        ? Colors.deepPurple
                                        : Colors.grey[300],
                                    borderRadius: BorderRadius.only(
                                      topLeft: const Radius.circular(12),
                                      topRight: const Radius.circular(12),
                                      bottomLeft: isCurrentUser
                                          ? const Radius.circular(12)
                                          : const Radius.circular(0),
                                      bottomRight: isCurrentUser
                                          ? const Radius.circular(0)
                                          : const Radius.circular(12),
                                    ),
                                  ),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        message.content ?? 'No Content',
                                        style: TextStyle(
                                          color: isCurrentUser
                                              ? Colors.white
                                              : Colors.black,
                                          fontSize: 16,
                                        ),
                                      ),
                                      const SizedBox(height: 4),
                                      Text(
                                        _formatTime(message.createdAt),
                                        style: TextStyle(
                                          color: isCurrentUser
                                              ? Colors.white70
                                              : Colors.black54,
                                          fontSize: 12,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          )
                        : const Center(
                            child: Text(
                              'No messages yet!',
                              style: TextStyle(fontSize: 18, color: Colors.grey),
                            ),
                          ),
                  ),
                  Container(
                    color: Colors.white,
                    padding: const EdgeInsets.all(8),
                    child: Row(
                      children: [
                        Expanded(
                          child: TextField(
                            controller: context.read<ChatBloc>().messageController,
                            decoration: InputDecoration(
                              hintText: 'Type your message...',
                              filled: true,
                              fillColor: Colors.grey[200],
                              contentPadding: const EdgeInsets.symmetric(horizontal: 16),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(24),
                                borderSide: BorderSide.none,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        CircleAvatar(
                          backgroundColor: Colors.deepPurple,
                          child: IconButton(
                            icon: const Icon(Icons.send, color: Colors.white),
                            onPressed: () {
                              final chatBloc = context.read<ChatBloc>();
                              if (chatBloc.messageController.text.isNotEmpty) {
                                chatBloc.add(SendMessage(
                                  chatId: widget.chatId,
                                  senderId: widget.userId,
                                  content: chatBloc.messageController.text,
                                ));
                                chatBloc.messageController.clear();
                                _scrollToBottom();
                              }
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              );
            } else if (state is ChatFailure) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Error: ${state.error}',
                      style: const TextStyle(color: Colors.red, fontSize: 16),
                    ),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: () {
                        context.read<ChatBloc>().add(FetchChatHistoryEvent(widget.chatId));
                      },
                      style:
                          ElevatedButton.styleFrom(backgroundColor: Colors.deepPurple),
                      child: const Text('Retry'),
                    ),
                  ],
                ),
              );
            } else {
              return const Center(child: Text('No chat messages available.'));
            }
          },
        ),
      ),
    );
  }
}
