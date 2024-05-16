import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:injectable/injectable.dart';
import 'package:twitch_clone/src/data/model/home/live_model.dart';
import 'package:twitch_clone/src/utils/api_client.dart';
import 'package:twitch_clone/src/utils/firebase_provider.dart';

@injectable
class Homerepository extends ApiClient {
  Stream<List<Livemodel>> getlive() {
    final Stream<QuerySnapshot> _homecollection =
        FirebaseFirestore.instance.collection('addlive').snapshots();
    final res =  _homecollection.map((snapshot) {
      return snapshot.docs.map((doc) {
    
        return Livemodel.fromJson(doc as DocumentSnapshot<Map<String, dynamic>>);
        
      }).toList();
    });
    print('test$res');
    return res;
  }
}
