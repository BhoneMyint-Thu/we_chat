import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';

import '../../../constant/hive_constant.dart';

part 'user_vo.g.dart';

@HiveType(typeId: kWeChatHiveType)
@JsonSerializable()
class UserVO {
  @JsonKey(name: 'id')
  @HiveField(0)
  String? id;

  @JsonKey(name: 'username')
  @HiveField(1)
  String? userName;

  @JsonKey(name: 'user_password')
  @HiveField(2)
  String? userPassword;

  @JsonKey(name: 'user_email')
  @HiveField(3)
  String? userEmail;

  @JsonKey(name: 'profile_pic')
  @HiveField(4)
  String? profilePic;

  @JsonKey(name: 'last_sent_message')
  @HiveField(5)
  String? lastSentMessage;

  @JsonKey(name: 'last_message_time')
  @HiveField(6)
  DateTime? lastMessageTime;

  @JsonKey(name: 'last_message_sender_id')
  @HiveField(7)
  String? lastMessageSenderId;

  UserVO(
      {required this.id,
      required this.userName,
      required this.userPassword,
      required this.userEmail,
      required this.profilePic,
      this.lastSentMessage,
      this.lastMessageTime,
      this.lastMessageSenderId});

  factory UserVO.fromJson(Map<String, dynamic> json) => _$UserVOFromJson(json);

  Map<String, dynamic> toJson() => _$UserVOToJson(this);
}
