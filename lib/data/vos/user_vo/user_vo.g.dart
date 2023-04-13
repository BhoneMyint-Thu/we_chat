// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_vo.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class UserVOAdapter extends TypeAdapter<UserVO> {
  @override
  final int typeId = 0;

  @override
  UserVO read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return UserVO(
      id: fields[0] as String?,
      userName: fields[1] as String?,
      userPassword: fields[2] as String?,
      userEmail: fields[3] as String?,
      profilePic: fields[4] as String?,
      lastSentMessage: fields[5] as String?,
      lastMessageTime: fields[6] as DateTime?,
      lastMessageSenderId: fields[7] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, UserVO obj) {
    writer
      ..writeByte(8)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.userName)
      ..writeByte(2)
      ..write(obj.userPassword)
      ..writeByte(3)
      ..write(obj.userEmail)
      ..writeByte(4)
      ..write(obj.profilePic)
      ..writeByte(5)
      ..write(obj.lastSentMessage)
      ..writeByte(6)
      ..write(obj.lastMessageTime)
      ..writeByte(7)
      ..write(obj.lastMessageSenderId);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UserVOAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserVO _$UserVOFromJson(Map<String, dynamic> json) => UserVO(
      id: json['id'] as String?,
      userName: json['username'] as String?,
      userPassword: json['user_password'] as String?,
      userEmail: json['user_email'] as String?,
      profilePic: json['profile_pic'] as String?,
      lastSentMessage: json['last_sent_message'] as String?,
      lastMessageTime: json['last_message_time'] == null
          ? null
          : DateTime.parse(json['last_message_time'] as String),
      lastMessageSenderId: json['last_message_sender_id'] as String?,
    );

Map<String, dynamic> _$UserVOToJson(UserVO instance) => <String, dynamic>{
      'id': instance.id,
      'username': instance.userName,
      'user_password': instance.userPassword,
      'user_email': instance.userEmail,
      'profile_pic': instance.profilePic,
      'last_sent_message': instance.lastSentMessage,
      'last_message_time': instance.lastMessageTime?.toIso8601String(),
      'last_message_sender_id': instance.lastMessageSenderId,
    };
