import 'dart:convert';

class FileModel {
  List<String> files;
  String folder;
  FileModel({
    required this.files,
    required this.folder,
  });


  factory FileModel.fromJson(Map<String, dynamic> map) {
    return FileModel(
      files: map['files'].cast<String>(),
      folder: map['folder'],
    );
  }
}
