import 'dart:convert';

FoodModel shopModelFromJson(String str) => FoodModel.fromJson(json.decode(str));

String shopModelToJson(FoodModel data) => json.encode(data.toJson());

class FoodModel {
  String? id;
  String? price;
  String? foodName;
  String? imgURL;
  String? about;

  FoodModel({this.id, this.price, this.foodName, this.imgURL , this.about});

  factory FoodModel.fromJson(Map<String, dynamic> json) => FoodModel(
      id: json["id"],
      price: json["price"],
      foodName: json["foodName"],
      imgURL: json["imgURL"],
      about: json["about"]
      );

  Map<String, dynamic> toJson() =>
      {"id": id, "price": price, "foodName": foodName, "imgURL": imgURL , "about":about};
}
