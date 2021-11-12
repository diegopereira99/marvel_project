import 'dart:convert';

class CharacterModel {
  String? id;
  String name;
  String description;
  String? image;
  CharacterModel({
    this.id,
    required this.name,
    required this.description,
    this.image,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'image': image,
    };
  }

  factory CharacterModel.fromMap(Map<String, dynamic> map) {
    return CharacterModel(
      id: map['id'].toString(),
      name: map['name'] ?? 'Sem nome',
      description: map['description'] ?? 'Sem descrição',
      image: map['image'],
    );
  }

  String toJson() => jsonEncode(toMap());

  factory CharacterModel.fromJson(String source) =>
      CharacterModel.fromMap(jsonDecode(source));
}
