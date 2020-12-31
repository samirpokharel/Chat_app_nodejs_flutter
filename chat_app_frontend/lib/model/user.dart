class User {
  String username;
  String id;

  User({this.id, this.username});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(id: json["_id"], username: json["username"]);
  }
  
}
