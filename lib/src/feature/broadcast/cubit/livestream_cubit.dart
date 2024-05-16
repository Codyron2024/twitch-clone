import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:image_picker/image_picker.dart';
import 'package:injectable/injectable.dart';
import 'package:twitch_clone/src/data/model/livechat/livechat_model.dart';
import 'package:twitch_clone/src/data/repository/livestream/livestream_repository.dart';
import 'package:twitch_clone/src/injection.dart';
import 'package:twitch_clone/src/utils/utils.dart';

part 'livestream_state.dart';
part 'livestream_cubit.freezed.dart';

@injectable
class LivestreamCubit extends Cubit<LivestreamState> {
  LivestreamCubit({required this.livestreamrepo})
      : super(const LivestreamState.initial());
  final Livestreamrepository livestreamrepo;
  pickfile() async {
    XFile? pickedImage = await pickImage();
    if (pickedImage != null) {
      emit(LivestreamState.imageload(pickedImage));
    }
  }

  createmeeting(String title, int watching, XFile? image) async {
    print('wew');
    emit(const LivestreamState.loading());
    final res = await livestreamrepo.createMeeting(title, watching, image);
    res.fold((l) => emit(LivestreamState.error(l)),
        (r) => emit(LivestreamState.success(r)));
  }

  roomid() async {
    String? roomids = await storage.read(key: 'roomid');
    emit(LivestreamState.meetingid(roomids));
  }

  getlivechat(String liveid) {
    final res = livestreamrepo.getlivechat(liveid);
    res.listen((event) {
      emit(LivestreamState.loadchat(event));
    });
  }

  @override
  Future<void> close() {
    getIt<LivestreamCubit>().close();
    return super.close();
  }
}
