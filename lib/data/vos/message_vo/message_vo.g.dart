// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'message_vo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MessageVO _$MessageVOFromJson(Map<String, dynamic> json) => MessageVO(
      json['message'] as String?,
      json['dateTime'] == null
          ? null
          : DateTime.parse(json['dateTime'] as String),
      json['sender_id'] as String?,
      json['message_id'] as String?,
    );

Map<String, dynamic> _$MessageVOToJson(MessageVO instance) => <String, dynamic>{
      'message': instance.message,
      'dateTime': instance.dateTime?.toIso8601String(),
      'sender_id': instance.senderId,
      'message_id': instance.messageId,
    };
