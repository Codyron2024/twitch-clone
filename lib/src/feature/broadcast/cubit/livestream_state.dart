part of 'livestream_cubit.dart';

@freezed
class LivestreamState with _$LivestreamState {
  const factory LivestreamState.initial() = _Initial;
  const factory LivestreamState.loading() = _Loading;
  const factory LivestreamState.success(dynamic success) = _Success;
  const factory LivestreamState.error(Exception error) = _Error;
  const factory LivestreamState.meetingid(String? meetingiddata) = _Meeting;
    const factory LivestreamState.loadchat(List<Livechatmodel> loadchat) = _Loadchat;
   const factory LivestreamState.imageload(XFile? image) = _Imageload; 
  

}
