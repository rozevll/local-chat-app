import 'dart:convert';
import 'dart:async';
import 'package:web_socket_channel/web_socket_channel.dart';
import '../models/chat.dart';

class WebSocketService {
  WebSocketChannel? _channel;
  final StreamController<Message> _messageController = StreamController<Message>.broadcast();
  final StreamController<String> _connectionController = StreamController<String>.broadcast();
  
  Stream<Message> get messageStream => _messageController.stream;
  Stream<String> get connectionStream => _connectionController.stream;
  
  bool get isConnected => _channel != null;

  // WebSocket 연결
  void connect(String userId) {
    try {
      _channel = WebSocketChannel.connect(
        Uri.parse('ws://localhost:7070/ws/chat?userId=$userId'),
      );

      _channel!.stream.listen(
        (data) {
          try {
            final messageData = jsonDecode(data);
            final message = Message.fromJson(messageData);
            _messageController.add(message);
          } catch (e) {
            print('메시지 파싱 오류: $e');
          }
        },
        onError: (error) {
          print('WebSocket 오류: $error');
          _connectionController.add('error');
        },
        onDone: () {
          print('WebSocket 연결 종료');
          _connectionController.add('disconnected');
        },
      );

      _connectionController.add('connected');
    } catch (e) {
      print('WebSocket 연결 실패: $e');
      _connectionController.add('error');
    }
  }

  // 메시지 전송
  void sendMessage(String content) {
    if (_channel != null) {
      final message = {
        'type': 'message',
        'content': content,
      };
      _channel!.sink.add(jsonEncode(message));
    }
  }

  // 연결 종료
  void disconnect() {
    _channel?.sink.close();
    _channel = null;
    _connectionController.add('disconnected');
  }

  // 리소스 정리
  void dispose() {
    disconnect();
    _messageController.close();
    _connectionController.close();
  }
}
