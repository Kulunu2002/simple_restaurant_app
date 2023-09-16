import 'package:food_app/controllers/cusController.dart';
import 'package:food_app/screens/shopScreens/addPromotion.dart';
import 'package:get/get.dart';
import '../models/foodModel.dart';
import '../models/promotion.dart';
import '../models/shopModel.dart';
import '../services/shopService.dart';

class ShopController extends GetxController {
  var shopM = ShopModel().obs;
  var shopLis = <ShopModel>[].obs;
  var foodLis = <FoodModel>[].obs;
  var ownerPromotionLis = <Promotion>[].obs;
  var promotionLis = <Promotion>[].obs;
  var cusController = Get.find<CustomerController>();

  //register shop
  Future<bool> registerShop({
    String? id,
    String? shopName,
    String? mobile,
    String? email,
    String? about,
    String? address,
    String? imgURL,
  }) async {
    ShopModel shopModel = ShopModel(
      id: id ?? "",
      shopName: shopName ?? "",
      email: email ?? "",
      mobile: mobile ?? "",
      about: about ?? "",
      address: address ?? "",
      imgURL: imgURL ?? "",
    );
    String? output = await ShopService().registerShop(shopModel);
    if (output == null) {
      return false;
    }
    shopM.value = shopModel;
    return true;
  }

//Get a user shop info
  Future<bool> getShopByID(String? id) async {
    ShopModel? shopModel = await ShopService().getShopByID(id);
    if (shopModel == null || shopModel.shopName == null) {
      return false;
    }
    shopM.value = shopModel;
    return true;
  }

  //Get All shop details
  Future<bool> getAllShop() async {
    List<ShopModel>? result = await ShopService().getAllShop();
    if (result == null) {
      return false;
    }

    for (ShopModel shopModel in result) {
      if (!cusController.pinnedListID.contains(shopModel.id)) {
        shopLis.add(shopModel);
      } else {
      }
    }

    return true;
  }

  //_____________________Add Food controller_____________________
  Future<bool> foodAdd({
    String? id,
    String? foodName,
    String? about,
    String? imgURL,
    String? price,
  }) async {
    FoodModel food = FoodModel(
        id: id ?? "",
        foodName: foodName ?? "",
        about: about ?? "",
        imgURL: imgURL ?? "",
        price: price ?? "");

    String? output = await ShopService().foodAdd(food);
    if (output == null) {
      return false;
    }
    foodLis.add(food);
    return true;
  }

//get all foods
  Future<bool> getAllFoods({String? cusID, String? id}) async {
    List<FoodModel>? result = await ShopService().getAllFoods();
    if (result == null) {
      return false;
    }
    for (FoodModel food in result) {
      if (id == food.id) {
        foodLis.add(food);
      }
    }
    return true;
  }

  //Add promotion controller
  Future<bool> addPromotion({
    String? id,
    String? about,
    String? imgURL,
  }) async {
    Promotion promotion = Promotion(
      id: id ?? "",
      about: about ?? "",
      imgURL: imgURL ?? "",
    );

    String? output = await ShopService().addPromotion(promotion);
    if (output == null) {
      return false;
    }
    ownerPromotionLis.add(promotion);
    return true;
  }

//get promotion for owners
  Future<bool> getPromotion({String? cusID, String? id}) async {
    List<Promotion>? result = await ShopService().getPromotion();
    if (result == null) {
      return false;
    }
    for (Promotion promotion in result) {
      if (id == promotion.id || cusID == cusController.customerM.value.id) {
        ownerPromotionLis.add(promotion);
      }
    }
    return true;
  }

//get all promotion 
  Future<bool> getAllPromotion() async {
    List<Promotion>? promotion = await ShopService().getAllPromotion();
    if (promotion == null || promotion.isEmpty) {
      return false;     
    }

    promotionLis.assignAll(promotion);
    return true;
  }
}
