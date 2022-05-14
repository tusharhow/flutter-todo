import 'dart:convert';

GenericResponse genericResponseFromJson(String str) =>
    GenericResponse.fromJson(json.decode(str));

String genericResponseToJson(GenericResponse data) =>
    json.encode(data.toJson());

class GenericResponse {
  GenericResponse({
    required this.message,
    required this.status,
  });

  String message;
  String status;

  factory GenericResponse.fromJson(Map<String, dynamic> json) =>
      GenericResponse(
        message: json["message"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "status": status,
      };
}
