import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';

import 'package:firebase_auth/firebase_auth.dart';

import 'package:injectable/injectable.dart';

import 'package:twitch_clone/src/data/model/user_model.dart';

import 'package:twitch_clone/src/utils/firebase_provider.dart';

@injectable
class Authenticationrepository {
  // Future<Either<Usererror, UserModel>> loginuser(
  //     String email, String password) async {
  //   try {
  //     Response response =
  //         await dio.post(servername + apiauth + loginendpoint, data: {
  //       'email': email,
  //       'password': password,
  //     });
  //     UserModel user = UserModel.fromJson(response.data);
  //     var token = response.data['token'];
  //     await storage.write(key: 'tokenaccess', value: token);
  //     print(token);

  //     return right(user);
  //   } on DioException catch (e) {
  //     var message = e.response?.data['message'];
  //     return left(Usererror(status: '', message: message));
  //   }
  // }
  CollectionReference users = firebasecore.collection('users');

  Future<Either<String, UserCredential>> loginuser(
      String email, String password) async {
    try {
      var credential = await firebaseauth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return right(credential);
    } on FirebaseAuthException catch (e) {
      var error = e.message;
      // if (e.code == 'weak-password') {
      //   print('The password provided is too weak.');
      // } else if (e.code == 'email-already-in-use') {
      //   print('The account already exists for that email.');
      // }
      return left(error.toString());
    }
  }

  Future<Either<String,UserCredential>> signupuser(
      String email, String password, String username) async {
    try {
      final credential = await firebaseauth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      await users.doc(firebaseauth.currentUser!.uid).set({'email': email, 'username': username});
      return right(credential);
    } on FirebaseAuthException catch (e) {
      var error = e.message;
      return left(error.toString());
    }
  }
}
