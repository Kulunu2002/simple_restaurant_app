import 'package:flutter/material.dart';
import 'package:food_app/controllers/shopController.dart';
import 'package:food_app/screens/customer%20screens/loginScreen.dart';
import 'package:food_app/screens/shopScreens/shHome.dart';
import 'package:food_app/screens/shopScreens/shRegister.dart';
import 'package:get/get.dart';

import '../../controllers/firebaseAppCtrl/authController.dart';
import '../../widgets/customButton.dart';
import '../../widgets/greyText.dart';
import '../../widgets/myTextField.dart';

class ShLogin extends StatefulWidget {
  const ShLogin({super.key});

  @override
  State<ShLogin> createState() => _ShLoginState();
}

class _ShLoginState extends State<ShLogin> {
  ShopController shopController = Get.find<ShopController>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController shNameController = TextEditingController();
  bool isLoading = false;
  bool checkBox = false;

  void check(bool? value) {
    setState(() {
      checkBox = value ?? false;
    });
  }

  void login() async {
    if (emailController.text.isEmpty || passwordController.text.isEmpty) {
      Get.snackbar('Invalid Input!', "Invalid Email Or Password");
      setState(() {
        isLoading = false;
      });
    }
    AuthController authController = AuthController();

    var output = await authController.signInUser(
        shNameController.text, emailController.text, passwordController.text);

    if (!output["isError"]) {
      String id = output["msg"] as String;

      var isShop = await shopController.getShopByID(id);

      if (isShop) {
        Get.offAll(() => const ShHome());
      } else {
        Get.snackbar("Error! User document not found", output["msg"]);
      }
      setState(() {
        isLoading = false;
      });
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
                    Get.to(() => const ShRegister());
                  },
                  child: const GreyText(
                    text: "Sign Up",
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
                        padding: const EdgeInsets.all(32),
                        child: SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                "Welcome Shop!",
                                style: TextStyle(
                                    fontSize: 32,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.black),
                              ),

                              const GreyText(
                                  text: "Please login with your information"),

                              const SizedBox(height: 30),

                              //name input
                              const GreyText(text: "Name"),
                              MyTextField(
                                  controller: shNameController,
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
                                  obscureText: true),

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
                                  const GreyText(text: "Forgot Password?")
                                ],
                              ),

                              const SizedBox(height: 40),

                              CustomButton(
                                onPressed: () {
                                  login();
                                },
                                text: "Log In",
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
                                btColor: Colors.black,
                              ),

                              Center(
                                child: TextButton(
                                    onPressed: () {
                                      Get.to(() => const LoginScreen());
                                    },
                                    child: const GreyText(
                                        text: "Login As A Customer")),
                              )
                            ],
                          ),
                        ),
                      ),
                    )))
          ]),
        ),
      ),
    );
  }
}
