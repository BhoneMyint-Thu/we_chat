import 'package:json_annotation/json_annotation.dart';
part 'post_vo.g.dart';
@JsonSerializable()
class PostVO {
  @JsonKey(name: 'username')
  String? username;

  @JsonKey(name: 'post_id')
  String? postId;

  @JsonKey(name: 'post_text')
  String ? postText;

  @JsonKey(name: 'posted_time')
  DateTime ? postedTime;

  PostVO({required this.postId,required this.postedTime,this.postText,this.username});

  factory PostVO.fromJson(Map<String,dynamic> json)=>_$PostVOFromJson(json);

  Map<String,dynamic> toJson()=>_$PostVOToJson(this);

}
