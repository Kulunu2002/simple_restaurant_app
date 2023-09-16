import 'dart:convert';

SavePromo shopModelFromJson(String str) => SavePromo.fromJson(json.decode(str));

String shopModelToJson(SavePromo data) => json.encode(data.toJson());

class SavePromo {
  String? id;
  bool? save;

  SavePromo({this.id,this.save});

  factory SavePromo.fromJson(Map<String, dynamic> json) => SavePromo(
      id: json["id"],
      save: json["save"],
      
      );

  Map<String, dynamic> toJson() =>
      {"id": id, "save": save};
}
