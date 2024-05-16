import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:twitch_clone/src/utils/utils.dart';

@injectable
class Securestorage {
  Future<Either<dynamic, String?>> savetoken() async {
    accesstoken = await storage.read(key: 'tokenaccess');
      print('Data read from secure storage: $accesstoken');
      return right(accesstoken);
  }
}
