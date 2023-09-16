import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/cusController.dart';
import '../../controllers/shopController.dart';

class Promo {
  bool isSave;

  Promo({required this.isSave});
}

class NewsCard extends StatefulWidget {
  const NewsCard({super.key});

  @override
  State<NewsCard> createState() => _NewsCardState();
}

class _NewsCardState extends State<NewsCard> {
  ShopController shopController = Get.find<ShopController>();
  CustomerController customerController = Get.find<CustomerController>();
  late List<Promo> promo;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    promo = List.generate(
      shopController.shopLis.length,
      (index) => Promo(isSave: false),
    );
  }

  void loadPromotion() async {
    await shopController.getAllPromotion();
    setState(() {
      promo = List.generate(
        shopController.shopLis.length,
        (index) => Promo(isSave: false),
      );
      isLoading = false;
    });
  }

  void savePromo(index, bool isSave) async {
    String? id = shopController.promotionLis[index].id;

    if (isSave) {
      bool pin = true;
      bool response = await customerController.addSavePromo(id: id, pin: pin);
      if (response) {
        Get.snackbar("Saved", "");
      }
    } else {
      bool pin = false;
      bool response = await customerController.unSavePromo(id: id, pin: pin);
      if (response) {
        Get.snackbar("UnSaved", "");
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: shopController.promotionLis.length,
        itemBuilder: (context, index) {
          final item = promo[index];
          final shop = shopController.promotionLis[index];
          return isLoading
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 10),
                    Card(
                      clipBehavior: Clip.antiAlias,
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(30)),
                      ),
                      color: Colors.white,
                      child: Column(
                        children: [
                          SizedBox(
                            height: 200,
                            width: double.infinity,
                            child: ClipRRect(
                              borderRadius: const BorderRadius.only(
                                bottomRight: Radius.circular(20),
                                bottomLeft: Radius.circular(20),
                              ),
                              child: Image.network(
                                '${shopController.promotionLis[index].imgURL}',
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 60,
                            child: ListTile(
                              title: Text(
                                "${shopController.promotionLis[index].about}",
                                style: const TextStyle(
                                    fontSize: 13, color: Colors.grey),
                              ),
                              trailing: IconButton(
                                onPressed: () {
                                  setState(() {
                                    item.isSave = !item.isSave;
                                    savePromo(index, item.isSave);
                                  });
                                },
                                icon: Icon(
                                  item.isSave
                                      ? Icons.favorite
                                      : Icons.favorite_border,
                                  color: item.isSave
                                      ? Colors.black
                                      : Colors.grey,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                );
        });
  }
}
