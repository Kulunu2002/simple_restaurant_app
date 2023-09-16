import 'package:flutter/material.dart';
import 'package:food_app/components/cusComponents/popUp.dart';
import 'package:food_app/screens/customer%20screens/loginScreen.dart';
import 'package:food_app/widgets/greyText.dart';
import 'package:get/get.dart';

import '../../controllers/cusController.dart';

class CusProfile extends StatefulWidget {
  const CusProfile({Key? key}) : super(key: key);

  @override
  State<CusProfile> createState() => _CusProfileState();
}

class _CusProfileState extends State<CusProfile> {
  var cusController = Get.find<CustomerController>();

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
            Get.back();
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
                const CircleAvatar(
                    radius: 50,
                    backgroundImage: AssetImage(
                      "assets/images/pp.jpeg",
                    )),
                Obx(() =>
                    GreyText(text: "${cusController.customerM.value.name}")),
                Obx(() =>
                    GreyText(text: "${cusController.customerM.value.email}")),
                const SizedBox(height: 30),
                Container(
                  width: double.infinity,
                  height: 300,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(15)),
                    color: Colors.white,
                    border: Border.all(
                      color: Colors.black,
                      width: 2.0,
                    ),
                  ),
                  child: Column(
                    children: const [
                      ListTile(
                        leading: Icon(Icons.list_alt_rounded),
                        title: GreyText(text: "My Orders"),
                        trailing: Icon(Icons.arrow_forward_ios),
                      ),
                      ListTile(
                        leading: Icon(Icons.language),
                        title: GreyText(text: "Language"),
                        trailing: Icon(Icons.arrow_forward_ios),
                      ),
                      ListTile(
                        leading: Icon(Icons.settings),
                        title: GreyText(text: "Setting"),
                        trailing: Icon(Icons.arrow_forward_ios),
                      ),
                      ListTile(
                        leading: Icon(Icons.place_outlined),
                        title: GreyText(text: "Address"),
                        trailing: Icon(Icons.arrow_forward_ios),
                      ),
                      ListTile(
                        leading: Icon(Icons.food_bank_sharp),
                        title: GreyText(text: "Food Hunt"),
                        trailing: Icon(Icons.arrow_forward_ios),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 50),
                Container(
                  width: double.infinity,
                  height: 50,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(15)),
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
                    onPressed: () {
                      Get.offAll(const LoginScreen());
                    },
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
