import 'dart:convert';

class UserPost {

  String email;

  String fullName;
  String password;
  String username;
  String birthday;
  List<String> roles;
  
  UserPost({
    required this.email,
    required this.fullName,
    required this.password,
    required this.username,
    required this.birthday,
    required this.roles,
  });






  Map<String, dynamic> toMap() {
    return {
      'email': email,
      'fullName': fullName,
      'password': password,
      'username': username,
      'birthday': birthday,
      'roles': roles,
    };
  }

  factory UserPost.fromMap(Map<String, dynamic> map) {
    return UserPost(
      email: map['email'] != null ? map['email'] :' ',
      fullName: map['fullName'] != null ? map['fullName'] :' ',
      password: map['password'] != null ? map['password'] :' ',
      username: map['username'] != null ? map['username'] :' ',
      birthday: map['birthday'] != null ? map['birthday'] :' ',
      roles: map['roles'] != null ? List<String>.from(map['roles']) :[],
    );
  }

  String toJson() => json.encode(toMap());

  factory UserPost.fromJson(String source) => UserPost.fromMap(json.decode(source));
}
