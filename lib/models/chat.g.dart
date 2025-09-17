// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chat.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ChatRoom _$ChatRoomFromJson(Map<String, dynamic> json) => ChatRoom(
  id: json['id'] as String,
  name: json['name'] as String,
  userIds: (json['userIds'] as List<dynamic>).map((e) => e as String).toList(),
  createdAt: DateTime.parse(json['createdAt'] as String),
  lastMessageAt: json['lastMessageAt'] == null
      ? null
      : DateTime.parse(json['lastMessageAt'] as String),
);

Map<String, dynamic> _$ChatRoomToJson(ChatRoom instance) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'userIds': instance.userIds,
  'createdAt': instance.createdAt.toIso8601String(),
  'lastMessageAt': instance.lastMessageAt?.toIso8601String(),
};

Message _$MessageFromJson(Map<String, dynamic> json) => Message(
  id: json['id'] as String,
  roomId: json['roomId'] as String,
  userId: json['userId'] as String,
  username: json['username'] as String,
  content: json['content'] as String,
  timestamp: DateTime.parse(json['timestamp'] as String),
  messageType: $enumDecode(_$MessageTypeEnumMap, json['messageType']),
);

Map<String, dynamic> _$MessageToJson(Message instance) => <String, dynamic>{
  'id': instance.id,
  'roomId': instance.roomId,
  'userId': instance.userId,
  'username': instance.username,
  'content': instance.content,
  'timestamp': instance.timestamp.toIso8601String(),
  'messageType': _$MessageTypeEnumMap[instance.messageType]!,
};

const _$MessageTypeEnumMap = {
  MessageType.chat: 'CHAT',
  MessageType.system: 'SYSTEM',
  MessageType.join: 'JOIN',
  MessageType.leave: 'LEAVE',
};

MessageRequest _$MessageRequestFromJson(Map<String, dynamic> json) =>
    MessageRequest(content: json['content'] as String);

Map<String, dynamic> _$MessageRequestToJson(MessageRequest instance) =>
    <String, dynamic>{'content': instance.content};

JoinRoomResponse _$JoinRoomResponseFromJson(Map<String, dynamic> json) =>
    JoinRoomResponse(
      roomId: json['roomId'] as String,
      message: json['message'] as String,
    );

Map<String, dynamic> _$JoinRoomResponseToJson(JoinRoomResponse instance) =>
    <String, dynamic>{'roomId': instance.roomId, 'message': instance.message};
