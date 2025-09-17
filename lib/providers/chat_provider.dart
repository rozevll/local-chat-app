import 'package:flutter/material.dart';
import '../models/chat.dart';
import '../services/api_service.dart';
import '../services/websocket_service.dart';

class ChatProvider extends ChangeNotifier {
  final ApiService _apiService = ApiService();
  WebSocketService? _webSocketService;
  
  List<ChatRoom> _rooms = [];
  List<Message> _messages = [];
  String? _currentRoomId;
  bool _isLoading = false;
  String? _error;
  bool _isConnected = false;

  List<ChatRoom> get rooms => _rooms;
  List<Message> get messages => _messages;
  String? get currentRoomId => _currentRoomId;
  bool get isLoading => _isLoading;
  String? get error => _error;
  bool get isConnected => _isConnected;

  // 채팅방 목록 조회
  Future<void> loadRooms(String token) async {
    _setLoading(true);
    _clearError();

    try {
      _rooms = await _apiService.getChatRooms(token);
      notifyListeners();
    } catch (e) {
      _setError(e.toString());
    } finally {
      _setLoading(false);
    }
  }

  // 랜덤 채팅방 입장
  Future<bool> joinRandomRoom(String userId, String token) async {
    _setLoading(true);
    _clearError();

    try {
      final response = await _apiService.joinRandomRoom(userId, token);
      _currentRoomId = response.roomId;
      
      // WebSocket 연결
      _connectWebSocket(userId);
      
      // 메시지 로드
      await loadMessages(_currentRoomId!, token);
      
      notifyListeners();
      return true;
    } catch (e) {
      _setError(e.toString());
      return false;
    } finally {
      _setLoading(false);
    }
  }

  // 채팅방 나가기
  Future<void> leaveRoom(String userId, String token) async {
    if (_currentRoomId == null) return;

    try {
      await _apiService.leaveRoom(_currentRoomId!, userId, token);
      _disconnectWebSocket();
      _currentRoomId = null;
      _messages.clear();
      notifyListeners();
    } catch (e) {
      _setError(e.toString());
    }
  }

  // 메시지 조회
  Future<void> loadMessages(String roomId, String token) async {
    try {
      _messages = await _apiService.getMessages(roomId, token);
      notifyListeners();
    } catch (e) {
      _setError(e.toString());
    }
  }

  // 메시지 전송
  void sendMessage(String content) {
    if (_webSocketService != null && _webSocketService!.isConnected) {
      _webSocketService!.sendMessage(content);
    }
  }

  // WebSocket 연결
  void _connectWebSocket(String userId) {
    _webSocketService = WebSocketService();
    _webSocketService!.connect(userId);
    
    _webSocketService!.messageStream.listen((message) {
      _messages.add(message);
      notifyListeners();
    });
    
    _webSocketService!.connectionStream.listen((status) {
      _isConnected = status == 'connected';
      notifyListeners();
    });
  }

  // WebSocket 연결 해제
  void _disconnectWebSocket() {
    _webSocketService?.dispose();
    _webSocketService = null;
    _isConnected = false;
  }

  void _setLoading(bool loading) {
    _isLoading = loading;
    notifyListeners();
  }

  void _setError(String error) {
    _error = error;
    notifyListeners();
  }

  void _clearError() {
    _error = null;
  }

  @override
  void dispose() {
    _disconnectWebSocket();
    super.dispose();
  }
}
