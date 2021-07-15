import 'dart:convert';

class ClientPost {
  String name;
  List<String> allowedGrantTypes;
  ClientPost({
    required this.name,
    required this.allowedGrantTypes,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'allowedGrantTypes': allowedGrantTypes,
    };
  }

  factory ClientPost.fromMap(Map<String, dynamic> map) {
    return ClientPost(
      name: map['name'],
      allowedGrantTypes: List<String>.from(map['allowedGrantTypes']),
    );
  }

  String toJson() => json.encode(toMap());

  factory ClientPost.fromJson(String source) => ClientPost.fromMap(json.decode(source));
}
