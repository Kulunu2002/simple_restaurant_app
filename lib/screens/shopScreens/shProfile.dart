import 'package:flutter/material.dart';
import 'package:food_app/components/cusComponents/popUp.dart';
import 'package:food_app/controllers/shopController.dart';
import 'package:food_app/screens/shopScreens/addFood.dart';
import 'package:food_app/screens/shopScreens/addPromotion.dart';
import 'package:food_app/widgets/greyText.dart';
import 'package:get/get.dart';

class ShProfile extends StatefulWidget {
  const ShProfile({Key? key}) : super(key: key);

  @override
  _ShProfileState createState() => _ShProfileState();
}

class _ShProfileState extends State<ShProfile> {
  ShopController shopController = Get.find<ShopController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.white,
        shadowColor: Colors.white,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: const Text(
          "Profile",
          style: TextStyle(
            color: Colors.black,
            fontSize: 30,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.edit, color: Colors.black),
            onPressed: () {
              showDialog(context: context, builder: (ctx) => const PopUpForm());
            },
          ),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Container(
            color: Colors.white,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                 CircleAvatar(
                    radius: 50,
                    backgroundImage: NetworkImage(
                       "${shopController.shopM.value.imgURL}"
                    )
                    ),
                 Obx(() => GreyText(
                  text: "${shopController.shopM.value.shopName}",
                )),
                 Obx(() => GreyText(
                  text: "${shopController.shopM.value.email}",
                )),
                
                const SizedBox(height: 30),
                Container(
                  width: double.infinity,
                  height: 300,
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(15)),
                    color: Colors.white,
                    border: Border.all(
                      color: Colors.black,
                      width: 2.0,
                    ),
                  ),
                  child: Column(
                    children: [
                      const ListTile(
                        leading: Icon(Icons.list_alt_rounded),
                        title: GreyText(text: "My Orders"),
                        trailing: Icon(Icons.arrow_forward_ios),
                      ),
                      const ListTile(
                        leading: Icon(Icons.language),
                        title: GreyText(text: "Language"),
                        trailing: Icon(Icons.arrow_forward_ios),
                      ),
                      const ListTile(
                        leading: Icon(Icons.settings),
                        title: GreyText(text: "Setting"),
                        trailing: Icon(Icons.arrow_forward_ios),
                      ),
                      ListTile(
                        leading: const Icon(Icons.newspaper_rounded),
                        title: const GreyText(text: "Promotion"),
                        trailing: const Icon(Icons.arrow_forward_ios),
                        onTap: () {
                          Get.to(() => const AddPromotion());
                        },
                      ),
                      ListTile(
                        leading: const Icon(Icons.food_bank_sharp),
                        title: const GreyText(text: "Foods"),
                        trailing: const Icon(Icons.arrow_forward_ios),
                        onTap: () {
                          Get.to(() => const AddFood());
                        },
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 50),
                Container(
                  width: double.infinity,
                  height: 50,
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(15)),
                    color: Colors.white,
                    border: Border.all(
                      color: Colors.black,
                      width: 2.0,
                    ),
                  ),
                  child: ElevatedButton(
                    style: ButtonStyle(
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                        ),
                        backgroundColor:
                            MaterialStateProperty.all(Colors.white)),
                    onPressed: () {},
                    child: const ListTile(
                      leading: Icon(Icons.logout_outlined),
                      title: GreyText(text: "Log Out"),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
