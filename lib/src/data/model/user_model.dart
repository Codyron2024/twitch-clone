import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';

part 'user_model.freezed.dart';
part 'user_model.g.dart';

@freezed
class UserModel with _$UserModel {
  const factory UserModel({
    num? id,
    String? name,
    String? email,
    DateTime? emailVerifiedAt,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) = _UserModel;

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);
}

@freezed
class AuthResponse with _$AuthResponse {
  const factory AuthResponse({
    required UserModel user,
    required String token,
    required int expire,
  }) = _AuthResponse;

  factory AuthResponse.fromJson(Map<String, dynamic> json) =>
      _$AuthResponseFromJson(json);
}

@freezed
class Usererror with _$Usererror {
  const factory Usererror({
    required String status,
    required String message,
  }) = _Usererror;

  factory Usererror.fromJson(Map<String, dynamic> json) =>
      _$UsererrorFromJson(json);
}
