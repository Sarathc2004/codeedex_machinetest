import 'dart:convert';

List<Categorymodel> categorymodelFromJson(String str) =>
    List<Categorymodel>.from(
        json.decode(str).map((x) => Categorymodel.fromJson(x)));

String categorymodelToJson(List<Categorymodel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Categorymodel {
  int? id;
  String? catName;

  Categorymodel({
    this.id,
    this.catName,
  });

  factory Categorymodel.fromJson(Map<String, dynamic> json) => Categorymodel(
        id: json["id"],
        catName: json["Cat_name"], // Make sure the API returns this key
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "Cat_name": catName,
      };
}
