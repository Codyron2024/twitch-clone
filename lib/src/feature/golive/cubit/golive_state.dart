import 'dart:io';
import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:image_picker/image_picker.dart';

part 'golive_state.freezed.dart';

@freezed
class GoliveState with _$GoliveState {
  const factory GoliveState.initial({
    XFile? image,

    
  }) = _Initial;
   const factory GoliveState.loading() = _Loading;

  const factory GoliveState.error(String errorMessage) = _Error;

  const factory GoliveState.success(bool issucess) = _Success;

}
