import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:food_app/screens/shopScreens/shLogin.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../controllers/firebaseAppCtrl/authController.dart';
import '../../controllers/shopController.dart';
import '../../widgets/customButton.dart';
import '../../widgets/greyText.dart';
import '../../widgets/myTextField.dart';

class ShRegister extends StatefulWidget {
  const ShRegister({super.key});

  @override
  State<ShRegister> createState() => _ShRegisterState();
}

class _ShRegisterState extends State<ShRegister> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController shNameController = TextEditingController();
  TextEditingController mobileController = TextEditingController();
  TextEditingController aboutController = TextEditingController();
  TextEditingController addressController = TextEditingController();

  FirebaseStorage storage = FirebaseStorage.instance;
  File? _photo;
  final ImagePicker _picker = ImagePicker();
  bool checkBox = false;

  void check(bool? value) {
    setState(() {
      checkBox = value ?? false;
    });
  }

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

  Future registerShop() async {
    AuthController authController = AuthController();

    var output = await authController.signUpUser(
        emailController.text, passwordController.text);
        
    if (_photo == null) return;

    
    if (output!["isError"]) {

  String extention =
          "simple_food_app_${DateTime.now().microsecondsSinceEpoch.toString().substring(10)}";
      final storageRef = storage
          .ref("/food_upload") //Folder Structure
          .child(AutofillHints.photo + extention); //File name
      final taskSnapshot = await storageRef.putFile(
        _photo!,
      );

      String url = await taskSnapshot.ref.getDownloadURL();

      String id = output["msg"] as String;
       var result = await ShopController().registerShop(
        id: id,
          email: emailController.text,
          mobile: mobileController.text,
          shopName: shNameController.text,
          address: addressController.text,
          about: aboutController.text,
          imgURL:url
          );
      if (result) {
        Get.off(() => const ShLogin());
      }
    } else {
      Get.snackbar("Something went wrong", output["msg"]);
    }

  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage("assets/images/cover.jpg"),
                fit: BoxFit.cover)),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: Stack(children: [
            Positioned(
                top: 20,
                left: 330,
                child: TextButton(
                  onPressed: () {
                    Get.to(() => const ShLogin());
                  },
                  child: const GreyText(
                    text: "Sign In",
                    textColor: Colors.white,
                  ),
                )),
            Positioned(
                bottom: 0,
                child: SizedBox(
                    height: 600,
                    width: MediaQuery.of(context).size.width,
                    child: Card(
                      shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30),
                        topRight: Radius.circular(30),
                      )),
                      child: Padding(
                        padding: const EdgeInsets.only(
                            top: 32, bottom: 5, right: 32, left: 32),
                        child: SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                "Start Your Shop!",
                                style: TextStyle(
                                    fontSize: 32,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.black),
                              ),

                              const GreyText(
                                  text:
                                      "Please register with your information"),

                              const SizedBox(height: 20),

                              //name input
                              const GreyText(text: "Shop Name"),
                              MyTextField(
                                  controller: shNameController,
                                  hintText: "",
                                  obscureText: false),

                              const SizedBox(height: 20),

                              //Mobile input
                              const GreyText(text: "Mobile"),
                              MyTextField(
                                  controller: mobileController,
                                  hintText: "",
                                  obscureText: false),

                              const SizedBox(height: 20),

                              //Email input
                              const GreyText(text: "Email"),
                              MyTextField(
                                  controller: emailController,
                                  hintText: "",
                                  obscureText: false),

                              const SizedBox(height: 20),

                              //password input
                              const GreyText(text: "Password"),
                              MyTextField(
                                  controller: passwordController,
                                  hintText: "",
                                  obscureText: false),

                              const SizedBox(height: 20),

                              //Address input
                              const GreyText(text: "Address"),
                              MyTextField(
                                  controller: addressController,
                                  hintText: "",
                                  obscureText: false),

                              const SizedBox(height: 20),

                              //About input
                              const GreyText(text: "About"),
                              MyTextField(
                                  controller: aboutController,
                                  hintText: "",
                                  obscureText: false),

                              const SizedBox(height: 20),

                              //password input
                              GestureDetector(
                                onTap: () {
                                  imgFromGallery();
                                },
                                child: Container(
                                  alignment: Alignment.center,
                                  width: double.infinity,
                                  height: 250,
                                  color: Colors.grey[300],
                                  child: _photo != null
                                      ? Image.file(_photo!, fit: BoxFit.cover)
                                      : const Text("Please select an image"),
                                ),
                              ),

                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Checkbox(
                                          value: checkBox, onChanged: check),
                                      const GreyText(text: "Remember Me")
                                    ],
                                  ),
                                ],
                              ),

                              const SizedBox(height: 20),

                              CustomButton(
                                onPressed: () {
                                  registerShop();
                                },
                                text: "Register",
                                width: 400.0,
                                buttonColor: MaterialStateProperty.all(
                                    const Color.fromARGB(255, 2, 75, 18)),
                                btColor: Colors.white,
                              ),

                              const SizedBox(height: 10),

                              CustomButton(
                                onPressed: () {
                                  // Your onPressed function
                                },
                                text: "Log In With Facebook",
                                width: 400.0,
                                buttonColor: MaterialStateProperty.all(
                                    Colors.transparent),
                                btColor: Colors.black, // Use Colors.transparent
                              ),
                            ],
                          ),
                        ),
                      ),
                    )))
          ]),
        ),
      ),
    );
    ;
  }
}
