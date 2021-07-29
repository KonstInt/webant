import 'dart:convert';

class MediaObjectAddModel {
    String file;
    String name;
    int? id;
  MediaObjectAddModel({
    required this.file,
    required this.name,
    this.id,
  });

  Map<String, dynamic> toMap() {
    return {
      'file': file,
      'name': name,
    };
  }

  factory MediaObjectAddModel.fromMap(Map<String, dynamic> map) {
    return MediaObjectAddModel(
      file: map['file'],
      name: map['name'],
      id: map['id'],
    );
  }

  String toJson() => json.encode(toMap());

  factory MediaObjectAddModel.fromJson(String source) => MediaObjectAddModel.fromMap(json.decode(source));
}
