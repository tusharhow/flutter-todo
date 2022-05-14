import 'dart:convert';

List<GetTodosModel>? getTodosModelFromJson(String? str) =>
    List<GetTodosModel>.from(
        json.decode(str!)!.map((x) => GetTodosModel.fromJson(x)));

String getTodosModelToJson(List<GetTodosModel>? data) =>
    json.encode(List<dynamic>.from(data!.map((x) => x.toJson())));

class GetTodosModel {
  GetTodosModel({
    required this.id,
    required this.title,
    required this.description,
    required this.createdAt,
  });

  String id;
  String title;
  String description;
  DateTime createdAt;

  factory GetTodosModel.fromJson(Map<String, dynamic> json) => GetTodosModel(
        id: json["id"],
        title: json["title"],
        description: json["description"],
        createdAt: DateTime.parse(json["created_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "description": description,
        "created_at": createdAt.toIso8601String(),
      };
}
