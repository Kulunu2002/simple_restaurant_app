import 'package:flutter/material.dart';
import 'package:food_app/controllers/shopController.dart';
import 'package:get/get.dart';

import '../../screens/customer screens/newsFeed.dart';

class NewsCardButton extends StatefulWidget {
  const NewsCardButton({super.key});

  @override
  State<NewsCardButton> createState() => _NewsCardButtonState();
}

class _NewsCardButtonState extends State<NewsCardButton> {
  ShopController shopController = Get.find<ShopController>();

  @override
  void initState() {
    super.initState();
    loadPromotion();  
  }


  void loadPromotion() async {
    await shopController.getAllPromotion();
    
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: shopController.promotionLis.length,
        itemBuilder: (context, index) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 10),
              TextButton(
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.white)),
                onPressed: () {
                  Get.to(() => const NewsFeed());
                },
                child: Card(
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
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
        });
  }
}
