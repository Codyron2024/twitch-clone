import 'package:dio/dio.dart';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:image_picker/image_picker.dart';

void showSnackBar(BuildContext context, String content) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(content),
    ),
  );
}

pickImage() async {
  final ImagePicker picker = ImagePicker();
  XFile? image = await picker.pickImage(
    source: ImageSource.gallery,
    imageQuality: 25,
  );

  return image;
}

Future<void> showMyDialog(BuildContext context,VoidCallback? tap,) async {
  return showDialog<void>(
    context: context,
    barrierDismissible: false, 
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('AlertDialog Title'),
        content: const SingleChildScrollView(
          child: ListBody(
            children: <Widget>[
              Text('This is a demo alert dialog.'),
              Text('Would you like to approve of this message?'),
            ],
          ),
        ),
        actions: <Widget>[
          TextButton(
            onPressed: tap,
            child: const Text('Ok'),
          ),
          TextButton(
            child: const Text('Cancel'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}

const storage = FlutterSecureStorage();
final Dio dio = Dio();
String? accesstoken;
const token =
    'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJhcGlrZXkiOiI0NThlN2ZiZS0xNmQ3LTRiZWEtOTg2YS1kZDMzN2ViZTE0NzgiLCJwZXJtaXNzaW9ucyI6WyJhbGxvd19qb2luIl0sImlhdCI6MTcxNDcyODc4MywiZXhwIjoxNzQ2MjY0NzgzfQ.p1_CaWqwG3q0A_-eRvZStLDByhl6xcy-LLf3s7X5NNE';

