import 'package:cloud_firestore/cloud_firestore.dart';

class Livemodel {
  String? image;
  String? title;
  String? username;
 int? watching;
 DateTime? datecreated;
 String? meetingid;
 String? liveid;


  Livemodel({this.image, this.title, this.username, this.watching,this.meetingid,this.liveid});

  Livemodel.fromJson(DocumentSnapshot<Map<String, dynamic>> json) {
    
    image = json['image'];
    title = json['title'];
 username = json['username'];
    watching = json['watching'];
    Timestamp? timestamp = json['datecreated'];
    datecreated = timestamp?.toDate();
    meetingid = json['meetingid'];
    liveid  = json.id;
    

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['image'] = this.image;
    data['title'] = this.title;
    data['username'] = this.username;
    data['watching'] = this.watching;
    data['meetingid'] = this.meetingid;
    return data;
  }
}
