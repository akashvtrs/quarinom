import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:quarinom/core/api/apiservice.dart';
import 'package:quarinom/presentation/bloc/chatbloc.dart';
import 'package:quarinom/presentation/screens/chatscreen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _searchController = TextEditingController();
  List<dynamic> _filteredChats = [];
  List<dynamic> _allChats = [];

  String _formatDateTime(String? dateTime) {
    if (dateTime == null) return 'Date/Time Unknown';
    final date = DateTime.parse(dateTime);
    return DateFormat('dd MMM yyyy, hh:mm a').format(date);
  }

  @override
  Widget build(BuildContext context) {
    final userId = ModalRoute.of(context)?.settings.arguments as String?;

    if (userId == null) {
      return Scaffold(
        appBar: AppBar(title: const Text('Chats')),
        body: const Center(child: Text('No user ID provided.')),
      );
    }

    return Scaffold(
   appBar: AppBar(
  title: const Text(
    'Chats',
    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
  ),
  backgroundColor: Colors.deepPurple,
  centerTitle: true,
  bottom: PreferredSize(
    preferredSize: const Size.fromHeight(80),
    child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Container(
        height: 50,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(30),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.3),
              spreadRadius: 2,
              blurRadius: 6,
              offset: const Offset(0, 2), // Shadow position
            ),
          ],
        ),
        child: TextField(
          controller: _searchController,
          onChanged: (query) {
            setState(() {
              _filteredChats = _allChats
                  .where(
                    (chat) => chat.participants?.first.name
                        ?.toLowerCase()
                        .contains(query.toLowerCase()),
                  )
                  .toList();
            });
          },
          style: const TextStyle(fontSize: 16),
          decoration: InputDecoration(
            hintText: 'Search chats...',
            hintStyle: TextStyle(color: Colors.grey[500]),
            prefixIcon: const Icon(Icons.search, color: Colors.deepPurple),
            suffixIcon: _searchController.text.isNotEmpty
                ? IconButton(
                    icon: const Icon(Icons.close, color: Colors.grey),
                    onPressed: () {
                      setState(() {
                        _searchController.clear();
                        _filteredChats = _allChats;
                      });
                    },
                  )
                : null,
            border: InputBorder.none,
            contentPadding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
          ),
        ),
      ),
    ),
  ),
),

      body: BlocProvider(
        create: (context) =>
            ChatBloc(ApiService())..add(FetchChats(userId)),
        child: BlocBuilder<ChatBloc, ChatState>(
          builder: (context, state) {
            if (state is ChatLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is ChatLoaded) {
              _allChats = state.chats;
              final chats = _searchController.text.isEmpty
                  ? _allChats
                  : _filteredChats;

              if (chats.isEmpty) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.chat_bubble_outline,
                          size: 100, color: Colors.grey[400]),
                      const SizedBox(height: 16),
                      Text(
                        'No chats available.',
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.grey[600],
                        ),
                      ),
                    ],
                  ),
                );
              }

              return ListView.separated(
                padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                itemCount: chats.length,
                separatorBuilder: (context, index) => const Divider(height: 1),
                itemBuilder: (context, index) {
                  final chat = chats[index];
                  final participant = chat.participants?.first;
                  final participantName = participant?.name ?? 'Unknown';
                  final participantPhone =
                      participant?.phone ?? 'Phone Unknown';
                  final lastSeen =
                      participant?.lastSeen ?? 'Last seen: Unknown';
                  final formattedLastSeen = _formatDateTime(lastSeen);

                  return Card(
                    elevation: 3,
                    margin: const EdgeInsets.symmetric(vertical: 6),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: ListTile(
                      leading: CircleAvatar(
                        backgroundColor: Colors.deepPurple,
                        child: const Icon(Icons.person, color: Colors.white),
                      ),
                      title: Text(
                        participantName,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            participantPhone,
                            style: const TextStyle(fontSize: 14),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            "Last seen: $formattedLastSeen",
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey[600],
                            ),
                          ),
                        ],
                      ),
                      trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => HistoryScreen(
                              chatId: chat.sId.toString(),
                              userId: userId,
                              chatName:  participantName
                              ,phonono:  participantPhone,
                            ),
                          ),
                        );
                      },
                    ),
                  );
                },
              );
            } else if (state is ChatFailure) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Error: ${state.error}',
                      style: const TextStyle(color: Colors.red),
                    ),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: () {
                        context.read<ChatBloc>().add(FetchChats(userId));
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.deepPurple,
                      ),
                      child: const Text('Retry'),
                    ),
                  ],
                ),
              );
            } else {
              return const Center(child: Text('Unknown state.'));
            }
          },
        ),
      ),
    );
  }
}
