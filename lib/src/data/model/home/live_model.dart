import 'package:cloud_firestore/cloud_firestore.dart';

class Livemodel {
  String? image;
  String? title;
  String? userid;
 int? watching;
 DateTime? datecreated;
 String? meetingid;
 String? liveid;


  Livemodel({this.image, this.title, this.userid, this.watching,this.meetingid,this.liveid});

  Livemodel.fromJson(DocumentSnapshot<Map<String, dynamic>> json) {
    
    image = json['image'];
    title = json['title'];
    userid = json['userid'];
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
    data['userid'] = this.userid;
    data['watching'] = this.watching;
    data['meetingid'] = this.meetingid;
    return data;
  }
}
