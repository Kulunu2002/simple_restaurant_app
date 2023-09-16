import 'package:flutter/material.dart';
import 'package:food_app/controllers/shopController.dart';
import 'package:get/get.dart';

class ShopItem {
  bool isPinned;

  ShopItem({required this.isPinned});
}

class ShNewsCard extends StatefulWidget {
  const ShNewsCard({Key? key}) : super(key: key);

  @override
  State<ShNewsCard> createState() => _ShNewsCardState();
}

class _ShNewsCardState extends State<ShNewsCard> {
  ShopController shopController = Get.find<ShopController>();
  late ShopItem shopItem;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    loadPromotion();
    shopItem = ShopItem(isPinned: false);
  }

  void loadPromotion() async {
    String? id = shopController.shopM.value.id;
    await shopController.getPromotion(id: id);
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: shopController.ownerPromotionLis.length,
        itemBuilder: (context, index) {
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
                          '${shopController.ownerPromotionLis[index].imgURL}',
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    
                    Container(
                      height: 60,
                      child: ListTile(
                        title: Text(
                          "${shopController.ownerPromotionLis[index].about}",
                          style:
                              const TextStyle(fontSize: 13, color: Colors.grey),
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
                            color:
                                shopItem.isPinned ? Colors.black : Colors.grey,
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
