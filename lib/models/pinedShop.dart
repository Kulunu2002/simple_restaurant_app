import 'dart:convert';

PinShop shopModelFromJson(String str) => PinShop.fromJson(json.decode(str));

String shopModelToJson(PinShop data) => json.encode(data.toJson());

class PinShop {
  String? id;
  bool? pined;

  PinShop({this.id,this.pined});

  factory PinShop.fromJson(Map<String, dynamic> json) => PinShop(
      id: json["id"],
      pined: json["pined"],
      
      );

  Map<String, dynamic> toJson() =>
      {"id": id, "pined": pined};
}
