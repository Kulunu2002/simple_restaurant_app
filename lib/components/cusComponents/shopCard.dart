import 'package:flutter/material.dart';
import 'package:food_app/components/cusComponents/pinShop.dart';
import 'package:food_app/controllers/cusController.dart';
import 'package:get/get.dart';

import 'shComponents/shNewsCard.dart';
import '../../controllers/shopController.dart';
import '../../screens/customer screens/shopView.dart';

class ShopCard extends StatefulWidget {
  const ShopCard({Key? key}) : super(key: key);

  @override
  State<ShopCard> createState() => _ShopCardState();
}

class _ShopCardState extends State<ShopCard> {
  ShopController shopController = Get.find<ShopController>();
  CustomerController customerController = Get.find<CustomerController>();

  late List<ShopItem> shopItems;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    loadFoods();
    shopItems = List.generate(
      shopController.shopLis.length,
      (index) => ShopItem(isPinned: false),
    );
  }

  void loadFoods() async {
    await shopController.getAllShop();
    shopItems = List.generate(
      shopController.shopLis.length,
      (index) => ShopItem(isPinned: false),
    );
    isLoading = false;
  }

  void pinedShop(index, bool isPinned) async {
    String? id = shopController.shopLis[index].id;

    if (!isPinned) {
      bool pin = true;
      bool response = await customerController.pinShop(id: id, pin: pin);
      if (response) {
        setState(() {
          customerController.pinnedList.add(shopController.shopLis[index]);
          
        });
        Get.snackbar("pinned", "");
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
    return Card(
      color: Colors.white,
      child: SizedBox(
        height: 420,
        width: 380,
        child: Column(
          children: [
            const Expanded(child: PinShop()),
            Expanded(
              child: ListView.builder(
                itemCount: shopController.shopLis.length,
                itemBuilder: (context, index) {
                  final item = shopItems[index];
                  final shop = shopController.shopLis[index];

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
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                              color: Colors.white,
                            ),
                            margin: const EdgeInsets.only(top: 10),
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 8.0),
                              child: ListTile(
                                leading: SizedBox(
                                  width: 60,
                                  height: 100,
                                  child: Image.network(
                                    "${shopController.shopLis[index].imgURL}",
                                    fit: BoxFit.fill,
                                  ),
                                ),
                                title: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                      "${shopController.shopLis[index].shopName}",
                                      style: const TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    Text(
                                      "${shopController.shopLis[index].about}",
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
                                      item.isPinned = false;
                                      pinedShop(index, false);
                                    });
                                  },
                                  icon: Icon(
                                    item.isPinned
                                        ? Icons.push_pin
                                        : Icons.push_pin_outlined,
                                    color: item.isPinned
                                        ? Colors.black
                                        : Colors.grey,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
