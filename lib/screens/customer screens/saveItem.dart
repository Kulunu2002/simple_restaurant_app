import 'package:flutter/material.dart';
import 'package:food_app/screens/customer%20screens/viewSavePro.dart';
import 'package:food_app/widgets/greyText.dart';
import 'package:get/get.dart';

class SaveItem extends StatefulWidget {
  const SaveItem({super.key});

  @override
  State<SaveItem> createState() => _SaveItemState();
}

class _SaveItemState extends State<SaveItem> {
  @override
  Widget build(BuildContext context) {
    return Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          TextButton(
            onPressed: () {
              Get.to(() => const ViewSave());
            },
            child: Container(
              width: 300,
              height: 200,
              decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.black,
                    width: 2.0,
                  ),
                  borderRadius: BorderRadius.circular(10)),
              child: const Center(
                child: ListTile(
                  leading: Icon(
                    Icons.save,
                    size: 60,
                  ),
                  title: GreyText(text: "View save promotion", fontSize: 20),
                  trailing: Icon(Icons.arrow_forward_ios),
                ),
              ),
            ),
          ),
          TextButton(
            onPressed: () {},
            child: Container(
              width: 300,
              height: 200,
              decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.black,
                    width: 2.0,
                  ),
                  borderRadius: BorderRadius.circular(10)),
              child: const Center(
                child: ListTile(
                  leading: Icon(
                    Icons.shopify_outlined,
                    size: 60,
                  ),
                  title: GreyText(text: "View pin shop", fontSize: 20),
                  trailing: Icon(Icons.arrow_forward_ios),
                ),
              ),
            ),
          )
        ]);
  }
}
