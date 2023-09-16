import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import '../controllers/shopController.dart';
import '../models/foodModel.dart';
import '../models/promotion.dart';
import '../models/shopModel.dart';

class ShopService {
  CollectionReference shops = FirebaseFirestore.instance.collection("Shops");
  CollectionReference foods = FirebaseFirestore.instance.collection("Foods");
  CollectionReference promotions = FirebaseFirestore.instance.collection("Promotions");
  var shopController = Get.find<ShopController>();
  var foodLis = <FoodModel>[].obs;
  var shopLis = <ShopModel>[].obs;
  var promotionLis = <Promotion>[].obs;
  var ownerPromotionLis = <Promotion>[].obs;

//Register shop as a document
  Future<String?> registerShop(ShopModel shopModel) async {
    try {
      await shops.doc(shopModel.id).set(shopModel.toJson());
      return "Added";
    } catch (e) {
      print("!!!-------RegisterCustomer error :" + e.toString());
      return null;
    }
  }

  Future<ShopModel?> getShopByID(String? id) async {
    try {
      DocumentSnapshot? snapshot = await shops.doc(id).get();
      if (snapshot.data() == null) {
        return null;
      }
      Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;
      ShopModel shopModel = ShopModel.fromJson(data);
      return shopModel;
    } catch (e) {
      print("!!!------- error: $e");
      return null;
    }
  }

//get all shop
  Future<List<ShopModel>> getAllShop() async {
    try {
      QuerySnapshot snapshot = await shops.get();

      for (var doc in snapshot.docs) {
        Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
        ShopModel shopModel = ShopModel.fromJson(data);
        shopLis.add(shopModel);
      }

      return shopLis;
    } catch (e) {
      print("!!!------- error: $e");
      return [];
    }
  }

// add foods
  Future<String?> foodAdd(FoodModel food) async {
    try {
      await shops.doc(shopController.shopM.value.id).collection("Foods").add(food.toJson());
      return "Added";
    } catch (e) {
      print("!!!-------ShopModel Add error: $e");
      return null;
    }
  }

  Future<List<FoodModel>> getAllFoods() async {
    try {
      QuerySnapshot? snapshot =
          await FirebaseFirestore.instance.collection("Shops").doc(shopController.shopM.value.id).collection("Foods").get();

      for (var doc in snapshot.docs) {
        Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
        FoodModel food = FoodModel.fromJson(data);
        foodLis.add(food);
      }
      return foodLis;
    } catch (e) {
      print("!!!------- error: $e");
      return [];
    }
  }


//Add Promotion
  Future<String?> addPromotion(Promotion promotion) async {
    try {

      await shops.doc(shopController.shopM.value.id).collection("Promotions").add(promotion.toJson());
      return "Added";
    } catch (e) {
      print("!!!-------ShopModel Add error: $e");
      return null;
    }
  }

//Get Promotion
  Future<List<Promotion>> getPromotion() async {
    try {
      QuerySnapshot? snapshot = await FirebaseFirestore.instance.collection("Shops").doc(shopController.shopM.value.id).collection("Promotions").get();
          

      for (var doc in snapshot.docs) {
        Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
        Promotion promotion = Promotion.fromJson(data);
        ownerPromotionLis.add(promotion);
      }
      return ownerPromotionLis;
    } catch (e) {
      print("!!!------- error: $e");
      return [];
    }
  }

 Future<List<Promotion>> getAllPromotion() async {
  try {
    QuerySnapshot shopSnapshot = await FirebaseFirestore.instance.collection("Shops").get();

    for (var shopDoc in shopSnapshot.docs) {
      QuerySnapshot promotionSnapshot = await shopDoc.reference.collection("Promotions").get();

      for (var doc in promotionSnapshot.docs) {
        Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
        Promotion promotion = Promotion.fromJson(data);
        promotionLis.add(promotion);
      }
    }

    return promotionLis;
  } catch (e) {
    print("!!!------- error: $e");
    return [];
  }
}


}
