import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_storage/firebase_storage.dart';

import 'package:image_picker/image_picker.dart';
import 'package:injectable/injectable.dart';
import 'package:path/path.dart';
import 'package:twitch_clone/src/utils/api_client.dart';

import 'package:twitch_clone/src/utils/firebase_provider.dart';
import 'package:twitch_clone/src/utils/utils.dart';

@injectable
class GoliveRepository extends ApiClient {

  Future<Either<Exception, bool>> sendmessage(
      String message, String liveid) async {
    try {
      String? username;
      var collection = FirebaseFirestore.instance.collection('users');
      var docSnapshot =
          await collection.doc(firebaseauth.currentUser!.uid).get();
      if (docSnapshot.exists) {
        Map<String, dynamic>? data = docSnapshot.data();
        var value = data?['username'];
        username = value;
      }

      await FirebaseFirestore.instance
          .collection('message')
          .doc(liveid)
          .collection('chat')
          .add(
        {
          'text': message,
          'timestamp': FieldValue.serverTimestamp(),
          'user': firebaseauth.currentUser!.uid,
          'username': username,
        },
      );

      return right(true);
    } catch (e) {
      return Left(Exception(e));
    }
  }
}
