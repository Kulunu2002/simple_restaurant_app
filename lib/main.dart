import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:food_app/screens/customer%20screens/loginScreen.dart';
import 'package:food_app/utils/appBind.dart';
import 'package:get/get.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp().whenComplete(() {
    debugPrint("fb connection is completed");
  });

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  
  @override
  Widget build(BuildContext context) {
    return  GetMaterialApp(
        title: 'Food App',
        debugShowCheckedModeBanner: false,
        initialBinding: AppBinding(),
        home:const LoginScreen());
  }
}
