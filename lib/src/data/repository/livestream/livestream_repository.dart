import 'dart:developer';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:injectable/injectable.dart';
import 'package:path/path.dart';
import 'package:twitch_clone/src/data/model/livechat/livechat_model.dart';
import 'package:twitch_clone/src/utils/firebase_provider.dart';
import 'package:twitch_clone/src/utils/utils.dart';

@injectable
class Livestreamrepository {
  final CollectionReference livechatstream = firebasecore.collection('message');

  Future<Either<Exception, dynamic>> createMeeting(
      String title, int watching, XFile? image) async {
    try {
      final res = await dio.post('https://api.videosdk.live/v2/rooms',
          options: Options(headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
            'Authorization': '$token',
          }));
      print(res.data);
      var data = res.data['roomId'];
      await storage.write(key: 'roomid', value: data);
      addlive(title, watching, image, data);
      log('bwe$data');
      return right(res);
    } catch (e) {
      return left(Exception(e));
    }
  }

  Future<Either<Exception, bool>> addlive(
    String title,
    int watching,
    XFile? image,
    String meetingid,
  ) async {
    final fileName = basename(image!.path);
    const destination = 'files/';
    try {
      String? username;
      var collection = FirebaseFirestore.instance.collection('users');
      var docSnapshot = await collection.doc(firebaseauth.currentUser!.uid ).get();
      if (docSnapshot.exists) {
        Map<String, dynamic>? data = docSnapshot.data();
        var user = data?['username'];
        username = user;
      
      }
      CollectionReference addcollection = firebasecore.collection('addlive');
      final ref = firebasestorage.ref(destination).child(fileName);

      UploadTask uploadTask = ref.putFile(File(image.path));

      TaskSnapshot taskSnapshot = await uploadTask;

      String imageurl = await taskSnapshot.ref.getDownloadURL();
      print(imageurl);
      final res = await addcollection.add(
        {
          'title': title,
          'watching': watching,
          'image': imageurl,
          'username': username,
          'datecreated': DateTime.now(),
          'meetingid': meetingid
        },
      );
      var liveid = res.id;
      await storage.write(key: 'liveid', value: liveid);

      print('tesss$liveid');
      return right(true);
    } catch (e) {
      print(e);
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
