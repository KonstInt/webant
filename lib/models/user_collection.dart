import 'dart:convert';

class UserCollection {
  int id;
  String email;
  bool enabled;
  String phone;
  String fullName;
  String username;
  String birthday;
  List<String> roles;
  
  UserCollection({
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

  factory UserCollection.fromMap(Map<String, dynamic> map) {
    return UserCollection(
      id: map['id'],
      email: map['email'],
      enabled: map['enabled'],
      phone: map['phone'] != null ? map['phone']: '',
      fullName: map['fullName'] != null ? map['fullName']: '',
      username: map['username']!= null ?map['username']: '',
      birthday: map['birthday'] != null ? map['birthday']: '',
      roles: List<String>.from(map['roles']),
    );
  }

  String toJson() => json.encode(toMap());

  factory UserCollection.fromJson(String source) => UserCollection.fromMap(json.decode(source));
}
