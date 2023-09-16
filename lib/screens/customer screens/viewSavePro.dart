import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../components/cusComponents/shComponents/shNewsCard.dart';
import '../../controllers/cusController.dart';
import '../../controllers/shopController.dart';

class ViewSave extends StatefulWidget {
  const ViewSave({Key? key}) : super(key: key);

  @override
  State<ViewSave> createState() => _ViewSaveState();
}

class _ViewSaveState extends State<ViewSave> {
  ShopController shopController = Get.find<ShopController>();
  CustomerController customerController = Get.find<CustomerController>();
  late List<ShopItem> shopItems;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    promotion();
    shopItems = List.generate(
      shopController.promotionLis.length,
      (index) => ShopItem(isPinned: false),
    );
  }

  void promotion() async {
    String? id = customerController.customerM.value.id;
    List<String> result = await customerController.getPromotionID(id);

    if (!result.isEmpty) {
      List<String> shopID = result;
      await customerController.getSavedPromotion(shopID);
    }

    shopItems = List.generate(
      shopController.shopLis.length,
      (index) => ShopItem(isPinned: true),
    );
    isLoading = false;
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: const Text(
          "News Feed",
          style: TextStyle(
            color: Colors.black,
            fontSize: 30,
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.start,
        ),
        backgroundColor: Colors.white,
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: shopController.promotionLis.length,
              itemBuilder: (context, index) {
                ShopItem shopItem = shopItems[index];
                return Column(
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
                                '${customerController.promotionList[index].imgURL}',
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 60,
                            child: ListTile(
                              title: Text(
                                "${customerController.promotionList[index].about}",
                                style: const TextStyle(
                                  fontSize: 13,
                                  color: Colors.grey,
                                ),
                              ),
                              trailing: IconButton(
                                onPressed: () {
                                  setState(() {
                                    shopItem.isPinned = !shopItem.isPinned;
                                  });
                                },
                                icon: Icon(
                                  shopItem.isPinned
                                      ? Icons.favorite
                                      : Icons.favorite_border,
                                  color: shopItem.isPinned
                                      ? Colors.red
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
              },
            ),
    );
  }
}
