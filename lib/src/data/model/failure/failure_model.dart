import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';

part 'failure_model.freezed.dart';
part 'failure_model.g.dart';

@freezed
class Failuremodel with _$Failuremodel {
  const factory Failuremodel({
    String? message,
  }) = _Failure;

  factory Failuremodel.fromJson(Map<String,dynamic> json) => _$FailuremodelFromJson(json);
}