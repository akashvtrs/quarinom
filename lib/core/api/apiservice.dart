import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:quarinom/core/models/chat.dart';
import 'package:quarinom/core/models/message.dart';
import 'package:quarinom/core/models/user.dart';

class ApiService {
  final String baseUrl = 'http://45.129.87.38:6065/';

  Future<LoginData> login(String email, String password, String role) async {
    final url = Uri.parse('${baseUrl}user/login');
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'email': email,
        'password': password,
        'role': role,
      }),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body); 
      return LoginData.fromJson(data);
    } else {
      final error = jsonDecode(response.body)['message'];
      throw Exception('Login failed: $error');
    }
  }

  Future<List<ViewChat>> getUserChats(String userId) async {
    final url = Uri.parse('${baseUrl}chats/user-chats/$userId');
    final response = await http.get(url);
  print(userId);
    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body); 
      return data.map((chat) => ViewChat.fromJson(chat)).toList();
    } else {
      final error = jsonDecode(response.body)['message'];
      print(error.toString());
      throw Exception('Failed to fetch chats: $error');
    }
  }
Future<List<ViewHistory>> getChatMessages(String chatId) async {
  final url = Uri.parse('${baseUrl}messages/get-messagesformobile/$chatId');
  try {
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      return data.map((msg) => ViewHistory.fromJson(msg)).toList();
    } else {
      final error = jsonDecode(response.body)['message'];
      throw Exception('Failed to fetch chat messages: $error');
    }
  } catch (e) {
    throw Exception('An error occurred while fetching chat messages: $e');
  }
}


  Future<void> sendMessage(String chatId, String senderId, String content,
      {String messageType = 'text', String fileUrl = ''}) async {
    final url = Uri.parse('${baseUrl}messages/sendMessage');
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'chatId': chatId,
        'senderId': senderId,
        'content': content,
        'messageType': messageType,
        'fileUrl': fileUrl,
      }),
    );
print(response.body);

    if (response.statusCode != 201) {
      final error = jsonDecode(response.body)['message'];
      throw Exception('Failed to send message: $error');
    }
  }
}
