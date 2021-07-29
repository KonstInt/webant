import 'dart:convert';

class PhotoPost {
  
  String name;
  String dateCreate;
  String description;
  bool isNew;
  bool isPopular;
  String image;
  PhotoPost({
    required this.name,
    required this.dateCreate,
    required this.description,
    required this.isNew,
    required this.isPopular,
    required this.image,
  });

  




  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'dateCreate': dateCreate,
      'description': description,
      'isNew': isNew,
      'isPopular': isPopular,
      'image': image,
    };
  }

  factory PhotoPost.fromMap(Map<String, dynamic> map) {
    return PhotoPost(
      name: map['name'],
      dateCreate: map['dateCreate'],
      description: map['description'],
      isNew: map['isNew'],
      isPopular: map['isPopular'],
      image:map['image'],
    );
  }

  String toJson() => json.encode(toMap());

  factory PhotoPost.fromJson(String source) => PhotoPost.fromMap(json.decode(source));
}

