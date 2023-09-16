import 'dart:convert';

Promotion shopModelFromJson(String str) => Promotion.fromJson(json.decode(str));

String shopModelToJson(Promotion data) => json.encode(data.toJson());

class Promotion {
  String? id;
  String? imgURL;
  String? about;

  Promotion({this.id, this.imgURL , this.about});

  factory Promotion.fromJson(Map<String, dynamic> json) => Promotion(
      id: json["id"],
      imgURL: json["imgURL"],
      about: json["about"]
      );

  Map<String, dynamic> toJson() =>
      {"id": id, "imgURL": imgURL , "about":about};
}
