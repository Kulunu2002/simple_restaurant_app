

import 'dart:convert';

CustomerModel customerModelFromJson(String str) => CustomerModel.fromJson(json.decode(str));

String customerModelToJson(CustomerModel data) => json.encode(data.toJson());

class CustomerModel {
  String? id;
  String? name;
  String? email;
  String? mobile;

  CustomerModel({
    this.id,
    this.name,
    this.email,
    this.mobile,
  });

  factory CustomerModel.fromJson(Map<String, dynamic> json) => CustomerModel(
        id: json["id"],
        name: json["name"],
        email: json["email"],
        mobile: json["country"],
      );

  get reference => null;

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "email": email,
        "mobile": mobile,
      };
}
