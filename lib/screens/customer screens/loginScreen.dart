import 'package:flutter/material.dart';
import 'package:food_app/screens/customer%20screens/homeScreen.dart';
import 'package:food_app/screens/customer%20screens/signUpScreen.dart';
import 'package:food_app/screens/shopScreens/shLogin.dart';
import 'package:food_app/widgets/customButton.dart';
import 'package:food_app/widgets/greyText.dart';
import 'package:food_app/widgets/myTextField.dart';
import 'package:get/get.dart';

import '../../controllers/cusController.dart';
import '../../controllers/firebaseAppCtrl/authController.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  CustomerController customerController = Get.find<CustomerController>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  bool isLoading = false;

   bool checkBox = false;

    void check(bool? value) {
      setState(() {
        checkBox = value ?? false;
      });
    }

    //Auth
    void login() async {
      if (emailController.text.isEmpty || passwordController.text.isEmpty) {
        Get.snackbar('Invalid Input!', "Invalid Email Or Password");
        setState(() {
          isLoading = false;
        });
      }
      AuthController authController = AuthController();

      var output = await authController.signInUser(
          nameController.text, emailController.text, passwordController.text);

      if (!output["isError"]) {
        String id = output["msg"] as String;

        var isCus = await customerController.getUserByID(id);

        if (isCus) {
          Get.offAll(() => const HomeScreen());
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
                    Get.to(() => const SignUpScreen());
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
                                "Welcome!",
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
                                  controller: nameController,
                                  hintText: "",
                                  obscureText: false),

                              const SizedBox(height: 20),

                              //Mobile input
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
                                onPressed: () {},
                                text: "Log In With Facebook",
                                width: 400.0,
                                buttonColor: MaterialStateProperty.all(
                                    Colors.transparent),
                                btColor: Colors.black,
                              ),

                              Center(
                                child: TextButton(
                                    onPressed: () {
                                      Get.to(() => const ShLogin());
                                    },
                                    child: const GreyText(
                                        text: "Login As A Shop")),
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
