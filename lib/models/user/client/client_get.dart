import 'dart:convert';

class ClientGet {
  int id;
  String name;
  String randomId;
  String secret;
  List<String> allowedGrantTypes;
  ClientGet({
    required this.id,
    required this.name,
    required this.randomId,
    required this.secret,
    required this.allowedGrantTypes,
  });



  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'randomId': randomId,
      'secret': secret,
      'allowedGrantTypes': allowedGrantTypes,
    };
  }

  factory ClientGet.fromMap(Map<String, dynamic> map) {
    return ClientGet(
      id: map['id'] != null ? map['id'] :0,
      name: map['name'] != null ? map['name'] :' ',
      randomId: map['randomId'] != null ? map['randomId'] :' ',
      secret: map['secret'] != null ? map['secret'] :' ',
      allowedGrantTypes: map ['allowedGrantTypes'] != null ? List<String>.from(map['allowedGrantTypes']) : [],
    );
  }

  String toJson() => json.encode(toMap());

  factory ClientGet.fromJson(String source) => ClientGet.fromMap(json.decode(source));
}
