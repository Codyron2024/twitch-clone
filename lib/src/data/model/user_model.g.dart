// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$UserModelImpl _$$UserModelImplFromJson(Map<String, dynamic> json) =>
    _$UserModelImpl(
      id: json['id'] as num?,
      name: json['name'] as String?,
      email: json['email'] as String?,
      emailVerifiedAt: json['emailVerifiedAt'] == null
          ? null
          : DateTime.parse(json['emailVerifiedAt'] as String),
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
      updatedAt: json['updatedAt'] == null
          ? null
          : DateTime.parse(json['updatedAt'] as String),
    );

Map<String, dynamic> _$$UserModelImplToJson(_$UserModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'email': instance.email,
      'emailVerifiedAt': instance.emailVerifiedAt?.toIso8601String(),
      'createdAt': instance.createdAt?.toIso8601String(),
      'updatedAt': instance.updatedAt?.toIso8601String(),
    };

_$AuthResponseImpl _$$AuthResponseImplFromJson(Map<String, dynamic> json) =>
    _$AuthResponseImpl(
      user: UserModel.fromJson(json['user'] as Map<String, dynamic>),
      token: json['token'] as String,
      expire: json['expire'] as int,
    );

Map<String, dynamic> _$$AuthResponseImplToJson(_$AuthResponseImpl instance) =>
    <String, dynamic>{
      'user': instance.user,
      'token': instance.token,
      'expire': instance.expire,
    };

_$UsererrorImpl _$$UsererrorImplFromJson(Map<String, dynamic> json) =>
    _$UsererrorImpl(
      status: json['status'] as String,
      message: json['message'] as String,
    );

Map<String, dynamic> _$$UsererrorImplToJson(_$UsererrorImpl instance) =>
    <String, dynamic>{
      'status': instance.status,
      'message': instance.message,
    };
