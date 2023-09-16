import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:food_app/components/cusComponents/newsCard.dart';
import 'package:food_app/controllers/cusController.dart';
import 'package:food_app/models/pinedShop.dart';
import 'package:food_app/models/promotion.dart';
import 'package:food_app/models/savePromo.dart';
import 'package:get/get.dart';

import '../models/customerModel.dart';
import '../models/shopModel.dart';

class CustomerService {
    CollectionReference shops = FirebaseFirestore.instance.collection("Shops");
  CustomerController customerController = Get.find<CustomerController>();
  CollectionReference customer =
      FirebaseFirestore.instance.collection("Customer");
  var cusList = <CustomerModel>[].obs;
  var pinedListID = <PinShop>[].obs;
  var pinedList = <ShopModel>[].obs;
  var promotionList = <Promotion>[].obs;

  Future<String?> registerCustomer(CustomerModel customerModel) async {
    try {
      if (customerModel.id != null) {
        await customer.doc(customerModel.id!).set(customerModel.toJson());
        return "Added";
      } else {
        print("Error: The customerModel.id is null.");
        return null;
      }
    } catch (e) {
      print("!!!-------RegisterCustomer error: " + e.toString());
      return null;
    }
  }

  Future<CustomerModel?> getUserByID(String id) async {
    try {
      DocumentSnapshot? snapshot = await customer.doc(id).get();
      if (snapshot.data() == null) {
        return null;
      }
      Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;
      CustomerModel customerModel = CustomerModel.fromJson(data);
      return customerModel;
    } catch (e) {
      print("!!!------- error: $e");
      return null;
    }
  }

  Future<List<CustomerModel>> getAllCustomer() async {
    try {
      QuerySnapshot snapshot = await customer.get();

      for (var doc in snapshot.docs) {
        Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
        CustomerModel customerModel = CustomerModel.fromJson(data);
        cusList.add(customerModel);
      }

      return cusList;
    } catch (e) {
      print("!!!------- error: $e");
      return [];
    }
  }

  Future<String?> pinShop(PinShop pinShop) async {
  try {
    final customerRef = customer.doc(customerController.customerM.value.id);
    final shopRef = customerRef.collection("Pinned Shop");
    final existingShop = await shopRef.doc(pinShop.id).get();

    if (existingShop.exists) {
      return "Shop already pinned";
    } else {
      await shopRef.doc(pinShop.id).set(pinShop.toJson());
      return "Added";
    }
  } catch (e) {
    print("!!!-------ShopModel Add error: $e");
    return null;
  }
}


  //unpinned shop
  Future<String?> unpinnedShop(String? id) async {
    try {
      await customer
          .doc(customerController.customerM.value.id)
          .collection("Pinned Shop")
          .doc(id)
          .delete();

      return "Deleted";
    } catch (e) {
      print("!!!-------Delete Unpinned Shop error: $e");
      return null;
    }
  }

// get pinned shop's id(s)
  Future<List<PinShop>> getPinnedIDs(String? customerId) async {
  try {
    QuerySnapshot snapshot = await FirebaseFirestore.instance
        .collection("Customer")
        .doc(customerId)
        .collection("Pinned Shop")
        .get();

    List<PinShop> pinnedShops = [];

    for (var doc in snapshot.docs) {
      Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
      PinShop pinShop = PinShop.fromJson(data);
      pinnedShops.add(pinShop);
    }

    return pinnedShops;
  } catch (e) {
    print("Error fetching pinned shops: $e");
    return [];
  }
  }

// get All pinned shop
  Future<List<ShopModel>> getAllPinnedShop() async {
    try {
      QuerySnapshot snapshot = await shops.get();

      for (var doc in snapshot.docs) {
        Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
        ShopModel shopModel = ShopModel.fromJson(data);
        pinedList.add(shopModel);
      }

      return pinedList;
    } catch (e) {
      print("!!!------- error: $e");
      return [];
    }
  }


  Future<String?> addSavePromo(SavePromo savePromo) async {
  try {
    final customerRef = customer.doc(customerController.customerM.value.id);
    final shopRef = customerRef.collection("Save Promotion");
    final existingShop = await shopRef.doc(savePromo.id).get();

    if (existingShop.exists) {
      return "Shop already pinned";
    } else {
      await shopRef.doc(savePromo.id).set(savePromo.toJson());
      return "Added";
    }
  } catch (e) {
    print("!!!-------SavePromo Add error: $e");
    return null;
  }
}

//unpinned shop
  Future<String?> unSavePromo(String? id) async {
    try {
      await customer
          .doc(customerController.customerM.value.id)
          .collection("Save Promotion")
          .doc(id)
          .delete();

      return "Deleted";
    } catch (e) {
      print("!!!-------Delete Save Promotion error: $e");
      return null;
    }
  }

  Future<String?> updateDetails(CustomerModel customerModel) async {
    try {
      if (customerModel.id != null) {
        await customer.doc(customerModel.id!).update(customerModel.toJson());
        return "Added";
      } else {
        print("Error: The customerModel.id is null.");
        return null;
      }
    } catch (e) {
      print("!!!-------Update error: " + e.toString());
      return null;
    }
  }


// get promotions's id(s)
  Future<List<Promotion>> getPromotionID(String? customerId) async {
  try {
    QuerySnapshot snapshot = await FirebaseFirestore.instance
        .collection("Customer")
        .doc(customerId)
        .collection("Promotions")
        .get();

    List<Promotion> promotionShops = [];

    for (var doc in snapshot.docs) {
      Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
      Promotion promotion = Promotion.fromJson(data);
      promotionShops.add(promotion);
    }

    return promotionShops;
  } catch (e) {
    print("Error fetching pinned shops: $e");
    return [];
  }
  }

//get all saved promotions
  Future<List<Promotion>> getSavedPromotion() async {
    try {
      QuerySnapshot snapshot = await shops.get();

      for (var doc in snapshot.docs) {
        Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
        Promotion promotion = Promotion.fromJson(data);
        promotionList.add(promotion);
      }

      return promotionList;
    } catch (e) {
      print("!!!------- error: $e");
      return [];
    }
  }
}
