import 'package:json_annotation/json_annotation.dart';

part 'chat.g.dart';

@JsonSerializable()
class ChatRoom {
  final String id;
  final String name;
  final List<String> userIds;
  final DateTime createdAt;
  final DateTime? lastMessageAt;

  ChatRoom({
    required this.id,
    required this.name,
    required this.userIds,
    required this.createdAt,
    this.lastMessageAt,
  });

  factory ChatRoom.fromJson(Map<String, dynamic> json) => _$ChatRoomFromJson(json);
  Map<String, dynamic> toJson() => _$ChatRoomToJson(this);
}

@JsonSerializable()
class Message {
  final String id;
  final String roomId;
  final String userId;
  final String username;
  final String content;
  final DateTime timestamp;
  final MessageType messageType;

  Message({
    required this.id,
    required this.roomId,
    required this.userId,
    required this.username,
    required this.content,
    required this.timestamp,
    required this.messageType,
  });

  factory Message.fromJson(Map<String, dynamic> json) => _$MessageFromJson(json);
  Map<String, dynamic> toJson() => _$MessageToJson(this);
}

@JsonSerializable()
class MessageRequest {
  final String content;

  MessageRequest({
    required this.content,
  });

  factory MessageRequest.fromJson(Map<String, dynamic> json) => _$MessageRequestFromJson(json);
  Map<String, dynamic> toJson() => _$MessageRequestToJson(this);
}

@JsonSerializable()
class JoinRoomResponse {
  final String roomId;
  final String message;

  JoinRoomResponse({
    required this.roomId,
    required this.message,
  });

  factory JoinRoomResponse.fromJson(Map<String, dynamic> json) => _$JoinRoomResponseFromJson(json);
  Map<String, dynamic> toJson() => _$JoinRoomResponseToJson(this);
}

enum MessageType {
  @JsonValue('CHAT')
  chat,
  @JsonValue('SYSTEM')
  system,
  @JsonValue('JOIN')
  join,
  @JsonValue('LEAVE')
  leave,
}
