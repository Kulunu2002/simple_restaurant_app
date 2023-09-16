import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/shopController.dart';
import '../../screens/customer screens/shopView.dart';

class FoodCard extends StatefulWidget {
  const FoodCard({super.key});

  @override
  State<FoodCard> createState() => _FoodCardState();
}

class _FoodCardState extends State<FoodCard> {
  ShopController shopController = Get.find<ShopController>();

  @override
  void initState() {
    super.initState();
    loadFoods();
  }

  void loadFoods() async {
    String? id = shopController.shopM.value.id;
    await shopController.getAllFoods(id: id);
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      child: SizedBox(
        width: 380,
        child: ListView.builder(
          itemCount: shopController.foodLis.length,
          itemBuilder: (context, index) {
            final item = 5;

            return ElevatedButton(
              style: ElevatedButton.styleFrom(
                  primary: Colors.transparent, padding: EdgeInsets.zero),
              onPressed: () {
                Get.to(() => const ShopView());
              },
              child: Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                ),
                margin: const EdgeInsets.only(top: 1, bottom: 1),
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: ListTile(
                    leading: SizedBox(
                      width: 60,
                      height: 100,
                      child: Image.network(
                        "${shopController.foodLis[index].imgURL}",
                        fit: BoxFit.fill,
                      ),
                    ),
                    title: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          "${shopController.foodLis[index].about}",
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Text(
                          "${shopController.foodLis[index].price}",
                          style: const TextStyle(
                            fontSize: 15,
                            color: Color.fromARGB(255, 97, 95, 95),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
