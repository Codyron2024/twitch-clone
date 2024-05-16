class Livechatmodel {
  String? text;
  String? timestamp;
  String? user;
  String? username;

  Livechatmodel({this.text, this.timestamp, this.user, this.username});

  Livechatmodel.fromJson(Map<String, dynamic> json) {
    text = json['text'];
    timestamp = json['timestamp'];
    user = json['user'];
    username = json['username'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['text'] = this.text;
    data['timestamp'] = this.timestamp;
    data['user'] = this.user;
    data['username'] = this.username;
    return data;
  }
}
