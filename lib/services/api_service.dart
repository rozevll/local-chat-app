import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/user.dart';
import '../models/chat.dart';

class ApiService {
  static const String baseUrl = 'http://localhost:7070/api';
  
  // HTTP 헤더 생성
  Map<String, String> _getHeaders({String? token}) {
    final headers = {
      'Content-Type': 'application/json',
    };
    
    if (token != null) {
      headers['Authorization'] = 'Bearer $token';
    }
    
    return headers;
  }

  // 회원가입
  Future<AuthResponse> register(RegisterRequest request) async {
    final response = await http.post(
      Uri.parse('$baseUrl/auth/register'),
      headers: _getHeaders(),
      body: jsonEncode(request.toJson()),
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      final data = jsonDecode(response.body);
      return AuthResponse.fromJson(data);
    } else {
      throw Exception('회원가입 실패: ${response.body}');
    }
  }

  // 로그인
  Future<AuthResponse> login(LoginRequest request) async {
    final response = await http.post(
      Uri.parse('$baseUrl/auth/login'),
      headers: _getHeaders(),
      body: jsonEncode(request.toJson()),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return AuthResponse.fromJson(data);
    } else {
      throw Exception('로그인 실패: ${response.body}');
    }
  }

  // 채팅방 목록 조회
  Future<List<ChatRoom>> getChatRooms(String token) async {
    final response = await http.get(
      Uri.parse('$baseUrl/chat/rooms'),
      headers: _getHeaders(token: token),
    );

    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      return data.map((json) => ChatRoom.fromJson(json)).toList();
    } else {
      throw Exception('채팅방 목록 조회 실패: ${response.body}');
    }
  }

  // 랜덤 채팅방 입장
  Future<JoinRoomResponse> joinRandomRoom(String userId, String token) async {
    final response = await http.post(
      Uri.parse('$baseUrl/chat/rooms/join?userId=$userId'),
      headers: _getHeaders(token: token),
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      final data = jsonDecode(response.body);
      return JoinRoomResponse.fromJson(data);
    } else {
      throw Exception('채팅방 입장 실패: ${response.body}');
    }
  }

  // 채팅방 나가기
  Future<void> leaveRoom(String roomId, String userId, String token) async {
    final response = await http.post(
      Uri.parse('$baseUrl/chat/rooms/$roomId/leave?userId=$userId'),
      headers: _getHeaders(token: token),
    );

    if (response.statusCode != 200 && response.statusCode != 204) {
      throw Exception('채팅방 나가기 실패: ${response.body}');
    }
  }

  // 메시지 조회
  Future<List<Message>> getMessages(String roomId, String token) async {
    final response = await http.get(
      Uri.parse('$baseUrl/chat/rooms/$roomId/messages'),
      headers: _getHeaders(token: token),
    );

    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      return data.map((json) => Message.fromJson(json)).toList();
    } else {
      throw Exception('메시지 조회 실패: ${response.body}');
    }
  }

  // 메시지 전송 (HTTP)
  Future<Message> sendMessage(String roomId, String userId, MessageRequest request, String token) async {
    final response = await http.post(
      Uri.parse('$baseUrl/chat/rooms/$roomId/messages?userId=$userId'),
      headers: _getHeaders(token: token),
      body: jsonEncode(request.toJson()),
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      final data = jsonDecode(response.body);
      return Message.fromJson(data);
    } else {
      throw Exception('메시지 전송 실패: ${response.body}');
    }
  }
}
