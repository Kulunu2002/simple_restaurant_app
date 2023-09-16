import 'package:flutter/material.dart';
import 'package:food_app/screens/customer%20screens/loginScreen.dart';
import 'package:food_app/widgets/customButton.dart';
import 'package:food_app/widgets/greyText.dart';
import 'package:food_app/widgets/myTextField.dart';
import 'package:get/get.dart';

import '../../controllers/cusController.dart';
import '../../controllers/firebaseAppCtrl/authController.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SingUpScreenState();
}

class _SingUpScreenState extends State<SignUpScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController mobileController = TextEditingController();

  void signUpUser() async {
    AuthController authController = AuthController();

    var output = await authController.signUpUser(
        emailController.text, passwordController.text);

    if (output!["isError"]) {
      String id = output["msg"] as String;
      var result = await CustomerController().registerCustomer(
          id: id,
          name: nameController.text,
          email: emailController.text,
          mobile: mobileController.text);
      if (result) {
        Get.off(() => const LoginScreen());
      }
    } else {
      Get.snackbar("Something went wrong", output["msg"]);
    }
  }

  @override
  Widget build(BuildContext context) {
    bool checkBox = false;

    void check(bool? value) {
      setState(() {
        checkBox = value ?? false;
      });
    }

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
                    Get.to(() => const LoginScreen());
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
                                "Welcome!",
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
                              const GreyText(text: "Name"),
                              MyTextField(
                                  controller: nameController,
                                  hintText: "",
                                  obscureText: false),

                              const SizedBox(height: 20),

                              //Email input
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
                                ],
                              ),

                              const SizedBox(height: 20),

                              CustomButton(
                                onPressed: () {
                                  signUpUser();
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
  }
}
