import 'dart:convert';

ShopModel shopModelFromJson(String str) => ShopModel.fromJson(json.decode(str));

String shopModelToJson(ShopModel data) => json.encode(data.toJson());

class ShopModel {
  String? id;
  String? shopName;
  String? email;
  String? mobile;
  String? about;
  String? address;
  String? imgURL;

  ShopModel(
      {this.id,
      this.shopName,
      this.email,
      this.mobile,
      this.about,
      this.address,
      this.imgURL});

  factory ShopModel.fromJson(Map<String, dynamic> json) => ShopModel(
        id: json["id"],
        shopName: json["shopName"],
        email: json["email"],
        mobile: json["mobile"],
        about: json["about"],
        address: json["address"],
        imgURL: json["imgURL"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "shopName": shopName,
        "email": email,
        "mobile": mobile,
        "about": about,
        "address": address,
        "imgURL": imgURL
      };
}
