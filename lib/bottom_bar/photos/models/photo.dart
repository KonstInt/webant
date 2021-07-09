class Photo {
  final int id;
  final String name;
  final String date;
  final String description;
  final bool? isNew;
  final bool? isPopular;
  final ServImage image;
  
  Photo(
      {required this.id,
      required this.name,
      required this.date,
      required this.description,
      required this.isNew,
      required this.isPopular,
      required this.image});

 
  factory Photo.fromJson(Map<String, dynamic> json) {
    return Photo(
        id: json['id'],
        name: (json['name']!=null) ? json['name'] : '',
        date: (json['dateCreate']!=null) ? json['dateCreate'] : '',
        description: (json['description']!=null) ? json['description'] : '',

        isNew: json['new'],
        isPopular: json['popular'],
        image: new ServImage(json['image']['id'], json['image']['name']));
  }
}

class ServImage {
  final int id;
  final String name;

  ServImage(this.id, this.name);
}
