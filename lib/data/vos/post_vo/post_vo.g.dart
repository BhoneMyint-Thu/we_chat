// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'post_vo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PostVO _$PostVOFromJson(Map<String, dynamic> json) => PostVO(
      postId: json['post_id'] as String?,
      postedTime: json['posted_time'] == null
          ? null
          : DateTime.parse(json['posted_time'] as String),
      postText: json['post_text'] as String?,
      username: json['username'] as String?,
    );

Map<String, dynamic> _$PostVOToJson(PostVO instance) => <String, dynamic>{
      'username': instance.username,
      'post_id': instance.postId,
      'post_text': instance.postText,
      'posted_time': instance.postedTime?.toIso8601String(),
    };
