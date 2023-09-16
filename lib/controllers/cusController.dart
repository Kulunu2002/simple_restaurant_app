import 'package:food_app/models/pinedShop.dart';
import 'package:food_app/models/promotion.dart';
import 'package:food_app/models/savePromo.dart';
import 'package:food_app/models/shopModel.dart';
import 'package:get/get.dart';
import '../models/customerModel.dart';
import '../services/customerService.dart';

class CustomerController extends GetxController {
  var customerM = CustomerModel().obs;
  var cusList = <CustomerModel>[].obs;
  var pinnedList = <ShopModel>[].obs;
  var pinnedListID = <String>[].obs;
  var promotionList = <Promotion>[].obs;
  var promotionListID = <String>[].obs;

  //register customer
  Future<bool> registerCustomer({
    String? id,
    String? name,
    String? email,
    String? mobile,
  }) async {
    CustomerModel customerModel = CustomerModel(
      id: id ?? "",
      name: name ?? "",
      email: email ?? "",
      mobile: mobile ?? "",
    );
    String? output = await CustomerService().registerCustomer(customerModel);
    if (output == null) {
      return false;
    }
    customerM.value = customerModel;
    return true;
  }

  //Get customer data
  Future<bool> getUserByID(String id) async {
    CustomerModel? customerModel = await CustomerService().getUserByID(id);
    if (customerModel == null || customerModel.name == null) {
      return false;
    }
    customerM.value = customerModel;
    return true;
  }

//get all customer
  Future<bool> getAllCustomer() async {
    List<CustomerModel>? result = await CustomerService().getAllCustomer();
    if (result == null) {
      return false;
    }
    for (CustomerModel customerModel in result) {
      cusList.add(customerModel);
    }
    return true;
  }

//________________pined shop__________________
  Future<bool> pinShop({
    String? id,
    bool? pin,
  }) async {
    PinShop pinShop = PinShop(
      id: id ?? "",
      pined: pin,
    );
    String? output = await CustomerService().pinShop(pinShop);
    if (output == null) {
      return false;
    }
    print("pin");

    return true;
  }

//________________UnPined shop__________________
  Future<bool> unpinShop({
    String? id,
    bool? pin,
  }) async {
    PinShop pinShop = PinShop(
      id: id ?? "",
    );
    String? output = await CustomerService().unpinnedShop(id);
    if (output == null) {
      return false;
    }
    print("Unpin");
    return true;
  }

//________________get pinned shops's IDs__________________
  Future<List<String>> getPinnedIDs(String? id) async {
    List<PinShop> pinnedShopIDs = await CustomerService().getPinnedIDs(id);

    List<String> ids = [];

    if (pinnedShopIDs.isEmpty) {
      return ids;
    }

    for (var pinnedShop in pinnedShopIDs) {
      String? shopId = pinnedShop.id.toString();
      ids.add(shopId);
      pinnedListID.add(shopId);
      print(">>>>>>>>>>>>>>>${pinnedListID}");
    }
    return ids;
  }

//Get pinned shop details
  Future<bool> getPinnedShops(List<String> shopIDs) async {
    List<ShopModel>? result = await CustomerService().getAllPinnedShop();
    if (result == null) {
      return false;
    }
    for (ShopModel shopModel in result) {
      if (shopIDs.contains(shopModel.id)) {
        pinnedList.add(shopModel);
      }
    }
    return true;
  }

  //write data of save promotion
  Future<bool> addSavePromo({
    String? id,
    bool? pin,
  }) async {
    SavePromo savePromo = SavePromo(
      id: id ?? "",
    );
    String? output = await CustomerService().addSavePromo(savePromo);
    if (output == null) {
      return false;
    }
    print("Saved");
    return true;
  }

  //________________unSave promotions shop__________________
  Future<bool> unSavePromo({
    String? id,
    bool? pin,
  }) async {
    SavePromo pinShop = SavePromo(
      id: id ?? "",
    );
    String? output = await CustomerService().unSavePromo(id);
    if (output == null) {
      return false;
    }
    print("UnSave");
    return true;
  }

//____________________get promotions's id_______
  Future<List<String>> getPromotionID(String? id) async {
    List<Promotion> svPromoIDs = await CustomerService().getPromotionID(id);

    List<String> ids = [];

    if (svPromoIDs.isEmpty) {
      return ids;
    }

    for (var pinnedShop in svPromoIDs) {
      String? promoId = pinnedShop.id.toString();
      ids.add(promoId);
      promotionListID.add(promoId);
    }
    return ids;
  }


  //____________________update user details
  Future<bool> updateDetails({
    String? id,
    String? name,
    String? mobile,
    String? email
  }) async {
    CustomerModel customerModel = CustomerModel(
      id: id ?? "",
      name: name ?? "",
      email: email ?? "",
      mobile: mobile ?? "",
    );
    String? output = await CustomerService().updateDetails(customerModel);
    if (output == null) {
      return false;
    }
    customerM.value = customerModel;
    print("object");
    return true;
  }

  //Get promotion details
  Future<bool> getSavedPromotion(List<String> promoIDs) async {
    List<Promotion>? result = await CustomerService().getSavedPromotion();
    if (result == null) {
      return false;
    }
    for (Promotion promotion in result) {
      if (promoIDs.contains(promotion.id)) {
        promotionList.add(promotion);
      }
    }
    return true;
  }
}
