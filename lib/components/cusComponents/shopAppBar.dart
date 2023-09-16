import 'package:flutter/material.dart';
import 'package:food_app/components/cusComponents/shopDetails.dart';
import 'package:food_app/controllers/shopController.dart';
import 'package:get/get.dart';

import '../../widgets/customButton.dart';
import '../../widgets/greyText.dart';

class ShopAppBar extends StatefulWidget {
  const ShopAppBar({super.key});

  @override
  State<ShopAppBar> createState() => _ShopAppBarState();
}

class _ShopAppBarState extends State<ShopAppBar> {
  ShopController shopController = Get.find<ShopController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 200,
            flexibleSpace: FlexibleSpaceBar(
              background: Image.network(
                 "${shopController.shopM.value.imgURL}",
                fit: BoxFit.cover,
              ),
            ),
            leading: Padding(
              padding: const EdgeInsets.only(left: 16),
              child: IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ),
            actions: const [
              CircleAvatar(
                backgroundColor: Colors.white,
                child: Icon(Icons.share, color: Colors.black),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: CircleAvatar(
                  backgroundColor: Colors.white,
                  child: Icon(Icons.search_rounded, color: Colors.black),
                ),
              ),
            ],
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                   GreyText(
                    text: "${shopController.shopM.value.shopName}",
                    fontSize: 20,
                    fw: FontWeight.bold,
                    textColor: Colors.black,
                  ),
                  const SizedBox(height: 10),
                   GreyText(
                    text:  "${shopController.shopM.value.address}",
                    fontSize: 16,
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: const [
                      GreyText(text: "4.3 "),
                      Icon(Icons.star),
                      Icon(Icons.star),
                      Icon(Icons.star),
                      Icon(Icons.star),
                      Icon(Icons.star),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const GreyText(
                        text: "Free Delivery within 25 minutes",
                        fontSize: 16,
                      ),
                      CustomButton(
                        onPressed: () {},
                        text: "TAKE AWAY",
                        buttonColor:
                            MaterialStateProperty.all(Colors.transparent),
                        btColor: Colors.black,
                        width: 120.0,
                      ),
                    ],
                  ),
                  const SizedBox(height: 30),
                  SizedBox(
                    height: 400,
                    child: ShopDetails(),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
