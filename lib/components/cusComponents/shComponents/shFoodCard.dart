import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controllers/shopController.dart';
import '../../../widgets/greyText.dart';

class ShFoodCard extends StatefulWidget {
  const ShFoodCard({Key? key}) : super(key: key);

  @override
  State<ShFoodCard> createState() => _ShFoodCardState();
}

class _ShFoodCardState extends State<ShFoodCard> {
  ShopController shopController = Get.find<ShopController>();
  bool light = true;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    loadFoods();
  }

  void loadFoods() async {
    String? id = shopController.shopM.value.id;
    await shopController.getAllFoods(id: id);
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: shopController.foodLis.length,
      itemBuilder: (context, index) {
        return isLoading
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : Container(
                width: 230,
                margin: const EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      flex: 2,
                      child: Image.network(
                        '${shopController.foodLis[index].imgURL}',
                        fit: BoxFit.cover,
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 1),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            GreyText(
                              text: "${shopController.foodLis[index].foodName}",
                              textColor: Colors.black,
                            ),
                            GreyText(
                              text: "${shopController.foodLis[index].price}",
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                IconButton(
                                  onPressed: () {},
                                  icon: const Icon(Icons.delete),
                                ),
                                IconButton(
                                  onPressed: () {},
                                  icon: const Icon(Icons.edit),
                                ),
                                Switch(
                                  value: light,
                                  activeColor: Colors.black,
                                  onChanged: (bool value) {
                                    setState(() {
                                      light = value;
                                    });
                                  },
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              );
      },
    );
  }
}
