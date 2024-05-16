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
  pickfile() async {
    XFile? pickedImage = await pickImage();
    if (pickedImage != null) {
      emit(GoliveState.initial(image: pickedImage));
    }
  }

  addlive(
    String title,
    int watching,
    XFile? image,
    String meetingid,
  ) async {
    emit(const GoliveState.loading());
    var res = await goliverepo.addlive(title, watching, image, meetingid);

    res.fold((l) => emit(GoliveState.error(l.toString())),
        (r) => emit(GoliveState.success(r)));
  }

  sendmessage(String message, String liveid) async {
    var res = await goliverepo.sendmessage(message,liveid);
  }

  @override
  Future<void> close() {
    getIt<GoliveCubit>().close();
    return super.close();
  }
}
