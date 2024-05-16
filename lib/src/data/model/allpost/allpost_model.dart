class Allpostmodel {
  String? status;
  List<Todos>? todos;

  Allpostmodel({this.status, this.todos});

  Allpostmodel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['todos'] != null) {
      todos = <Todos>[];
      json['todos'].forEach((v) {
        todos!.add(new Todos.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.todos != null) {
      data['todos'] = this.todos!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Todos {
  String? username;
  Todo? todo;

  Todos({this.username, this.todo});

  Todos.fromJson(Map<String, dynamic> json) {
    username = json['username'];
    todo = json['todo'] != null ? new Todo.fromJson(json['todo']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['username'] = this.username;
    if (this.todo != null) {
      data['todo'] = this.todo!.toJson();
    }
    return data;
  }
}

class Todo {
  int? postId;
  int? userId;
  String? title;
  int? watching;
  String? image;
  String? createdAt;
  String? updatedAt;

  Todo(
      {this.postId,
      this.userId,
      this.title,
      this.watching,
      this.image,
      this.createdAt,
      this.updatedAt});

  Todo.fromJson(Map<String, dynamic> json) {
    postId = json['post_id'];
    userId = json['user_id'];
    title = json['title'];
    watching = json['watching'];
    image = json['image'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['post_id'] = this.postId;
    data['user_id'] = this.userId;
    data['title'] = this.title;
    data['watching'] = this.watching;
    data['image'] = this.image;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
