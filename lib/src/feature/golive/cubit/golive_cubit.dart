import 'dart:io';
import 'dart:math';
import 'dart:typed_data';

import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:image_picker/image_picker.dart';
import 'package:injectable/injectable.dart';
import 'package:twitch_clone/src/data/repository/golive/golive_repository.dart';
import 'package:twitch_clone/src/feature/golive/cubit/golive_state.dart';
import 'package:twitch_clone/src/injection.dart';
import 'package:twitch_clone/src/utils/utils.dart';

@injectable
class GoliveCubit extends Cubit<GoliveState> {
  GoliveCubit({required this.goliverepo})
      : super(const GoliveState.initial(
          image: null,
        ));
  final GoliveRepository goliverepo;


  

  sendmessage(String message, String liveid) async {
    var res = await goliverepo.sendmessage(message,liveid);
  }

  @override
  Future<void> close() {
    getIt<GoliveCubit>().close();
    return super.close();
  }
}
