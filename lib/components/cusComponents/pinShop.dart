import 'package:flutter/material.dart';
import 'package:food_app/components/cusComponents/shComponents/shNewsCard.dart';
import 'package:food_app/controllers/cusController.dart';
import 'package:get/get.dart';

import '../../controllers/shopController.dart';
import '../../screens/customer screens/shopView.dart';
import 'newsCard.dart';

class PinShop extends StatefulWidget {
  const PinShop({Key? key}) : super(key: key);

  @override
  State<PinShop> createState() => _PinShopState();
}

class _PinShopState extends State<PinShop> {
  ShopController shopController = Get.find<ShopController>();
  CustomerController customerController = Get.find<CustomerController>();

  late List<ShopItem> shopItems;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    loadPinShop();
  }

  void loadPinShop() async {
    String? id = customerController.customerM.value.id;
    List<String> result = await customerController.getPinnedIDs(id);

    if (!result.isEmpty) {
      List<String> shopID = result;
      await customerController.getPinnedShops(shopID);
    }

    shopItems = List.generate(
      shopController.shopLis.length,
      (index) => ShopItem(isPinned: true),
    );
    isLoading = false;
  }

  void unPinedShop(index, bool isPinned) async {
    String? id = shopController.shopLis[index].id;

    if (isPinned) {
      bool pin = false;
      bool response = await customerController.unpinShop(id: id, pin: pin);
      if (response) {
        setState(() {
          customerController.pinnedList.removeAt(index);
          
          
        });
        Get.snackbar("Unpinned", "");
      }
    }
  }

  void viewShop(index) async {
    String? id = shopController.shopLis[index].id;
    bool result = await shopController.getShopByID(id);

    if (result) {
      Get.to(() => const ShopView());
    } else {
      Get.snackbar("Try again.!", "");
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: customerController.pinnedList.length,
      itemBuilder: (context, index) {
        final item = shopItems[index];
        final shop = customerController.pinnedList[index];

        return isLoading
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Colors.transparent,
                  padding: EdgeInsets.zero,
                ),
                onPressed: () {
                  viewShop(index);
                },
                child: Container(
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    color: Colors.white,
                  ),
                  margin: const EdgeInsets.only(top: 10),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: ListTile(
                      leading: SizedBox(
                        width: 60,
                        height: 100,
                        child: Image.network(
                          "${customerController.pinnedList[index].imgURL}",
                          fit: BoxFit.fill,
                        ),
                      ),
                      title: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            "${customerController.pinnedList[index].shopName}",
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Text(
                            "${customerController.pinnedList[index].about}",
                            style: const TextStyle(
                              fontSize: 15,
                              color: Color.fromARGB(255, 97, 95, 95),
                            ),
                          ),
                        ],
                      ),
                      trailing: IconButton(
                        onPressed: () {
                          setState(() {
                            item.isPinned = true;
                            unPinedShop(index, true);
                          });
                        },
                        icon: Icon(
                          item.isPinned
                              ? Icons.push_pin
                              : Icons.push_pin_outlined,
                          color: item.isPinned ? Colors.black : Colors.grey,
                        ),
                      ),
                    ),
                  ),
                ),
              );
      },
    );
  }
}
