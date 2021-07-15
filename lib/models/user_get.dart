import 'dart:convert';

class UserGet {
  int id;
  String email;
  bool enabled;
  String phone;
  String fullName;
  String username;
  String birthday;
  List<String> roles;
  UserGet({
    required this.id,
    required this.email,
    required this.enabled,
    required this.phone,
    required this.fullName,
    required this.username,
    required this.birthday,
    required this.roles,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'email': email,
      'enabled': enabled,
      'phone': phone,
      'fullName': fullName,
      'username': username,
      'birthday': birthday,
      'roles': roles,
    };
  }

  factory UserGet.fromMap(Map<String, dynamic> map) {
    return UserGet(
      id: map['id'],
      email: map['email'] != null ? map['email'] :'',
      enabled: map['enabled'],
      phone: map['phone'] != null ? map['phone']:'',
      fullName: map['fullName'] != null ? map['fullName'] :'',
      username: map['username'] != null ? map['username'] :'',
      birthday: map['birthday'] != null ? map['birthday'] :'',
      roles: List<String>.from(map['roles']),
    );
  }

  String toJson() => json.encode(toMap());

  factory UserGet.fromJson(String source) => UserGet.fromMap(json.decode(source));
}
