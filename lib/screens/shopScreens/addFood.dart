import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:food_app/controllers/shopController.dart';
import 'package:food_app/screens/shopScreens/shHome.dart';
import 'package:food_app/widgets/customButton.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class AddFood extends StatefulWidget {
  const AddFood({Key? key}) : super(key: key);

  @override
  State<AddFood> createState() => _AddFoodState();
}

class _AddFoodState extends State<AddFood> {
  ShopController shopController = Get.find<ShopController>();
  TextEditingController nameController = TextEditingController();
  TextEditingController aboutController = TextEditingController();
  TextEditingController priceController = TextEditingController();

  FirebaseStorage storage = FirebaseStorage.instance;
  File? _photo;
  final ImagePicker _picker = ImagePicker();
  bool isLoading = false;

  Future imgFromGallery() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    setState(() {
      if (pickedFile != null) {
        _photo = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }

  Future addFood() async {
    if (_photo == null) return;

    try {
      String extention =
          "simple_food_app_${DateTime.now().microsecondsSinceEpoch.toString().substring(10)}";
      final storageRef = storage
          .ref("/food_upload") //Folder Structure
          .child(AutofillHints.photo + extention); //File name
      final taskSnapshot = await storageRef.putFile(
        _photo!,
      );
      String url = await taskSnapshot.ref.getDownloadURL();
      String? id = shopController.shopM.value.id;

      var result = await ShopController().foodAdd(
        id: id,
        foodName: nameController.text,
        about: aboutController.text,
        imgURL: url,
        price: priceController.text,
      );

      setState(() {
        isLoading = false;
      });

      if (result) {
        Get.snackbar("Food Added", "");
        Get.to(() =>const ShHome());
      }
    } catch (e) {
      print('error occured');
    }
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          leading: IconButton(
              onPressed: () {
                Get.back();
              },
              icon: const Icon(Icons.arrow_back, color: Colors.black)),
          title: const Text(
            "Add Product",
            style: TextStyle(color: Colors.black),
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(top: 10, right: 10, left: 10),
            child: Container(
              color: Colors.white,
              child: Column(
                children: [
                  TextFormField(
                    controller: nameController,
                    cursorColor: Colors.black,
                    decoration: const InputDecoration(
                      labelText: "Product Name",
                      labelStyle: TextStyle(color: Colors.black),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.black),
                      ),
                    ),
                  ),

                  const SizedBox(height: 10),

                  TextFormField(
                    controller: aboutController,
                    cursorColor: Colors.black,
                    decoration: const InputDecoration(
                      hintMaxLines: 3,
                      labelText: "Product About",
                      labelStyle: TextStyle(
                        color: Colors.black,
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.black),
                      ),
                    ),
                  ),

                  const SizedBox(height: 20),

                  GestureDetector(
                    onTap: () {
                      imgFromGallery();
                    },
                    child: Container(
                      alignment: Alignment.center,
                      width: double.infinity,
                      height: 300,
                      color: Colors.grey[300],
                      child: _photo != null
                          ? Image.file(_photo!, fit: BoxFit.cover)
                          : const Text("Please select an image"),
                    ),
                  ),

                  const SizedBox(height: 10),

                  //price input
                  TextFormField(
                    controller: priceController,
                    cursorColor: Colors.black,
                    decoration: const InputDecoration(
                      labelText: "Price",
                      labelStyle: TextStyle(
                        color: Colors.black,
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.black),
                      ),
                    ),
                  ),

                  const SizedBox(height: 55),

                  CustomButton(
                    onPressed: () {
                      addFood();
                    },
                    text: "Add",
                    width: 250.0,
                    buttonColor: MaterialStateProperty.all(
                        const Color.fromARGB(255, 2, 75, 18)),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
