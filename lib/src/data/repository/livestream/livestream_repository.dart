import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:twitch_clone/src/data/model/livechat/livechat_model.dart';
import 'package:twitch_clone/src/utils/firebase_provider.dart';
import 'package:twitch_clone/src/utils/utils.dart';

const token =
    'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJhcGlrZXkiOiI0NThlN2ZiZS0xNmQ3LTRiZWEtOTg2YS1kZDMzN2ViZTE0NzgiLCJwZXJtaXNzaW9ucyI6WyJhbGxvd19qb2luIl0sImlhdCI6MTcxNDcyODc4MywiZXhwIjoxNzQ2MjY0NzgzfQ.p1_CaWqwG3q0A_-eRvZStLDByhl6xcy-LLf3s7X5NNE';

@injectable
class Livestreamrepository {
  final Dio _dio = Dio();
  final CollectionReference livechatstream = firebasecore.collection('message');

  Future<Either<Exception, dynamic>> createMeeting() async {
    try {
      final res = await _dio.post('https://api.videosdk.live/v2/rooms',
          options: Options(headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
            'Authorization': '$token',
          }));
      print(res.data);
      var data = res.data['roomId'];
      await storage.write(key: 'roomid', value: data);
      log('bwe$data');
      return right(res);
    } catch (e) {
      return left(Exception(e));
    }
  }

  Stream<List<Livechatmodel>> getlivechat(String liveid) {
    final res = livechatstream
        .doc(liveid)
        .collection('chat')
        .orderBy('timestamp', descending: true);

    return res.snapshots().map((event) {
      return event.docs.map((e) {
        Map<String, dynamic> data = e.data() as Map<String, dynamic>;
        return Livechatmodel.fromJson(data);
      }).toList();
    });
  }
}
