import 'package:flutter/material.dart';
import 'package:food_app/components/cusComponents/shComponents/shNewsCard.dart';
import 'package:food_app/components/cusComponents/shComponents/shFoodCard.dart';
import 'package:food_app/controllers/shopController.dart';
import 'package:food_app/widgets/greyText.dart';
import 'package:get/get.dart';

class ShHomeCom extends StatefulWidget {
  const ShHomeCom({Key? key}) : super(key: key);

  @override
  State<ShHomeCom> createState() => _ShHomeComState();
}

class _ShHomeComState extends State<ShHomeCom> {
  ShopController shopController = Get.find<ShopController>();
  bool light = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffcbcbcb),
      appBar: AppBar(
        title: const Text(
          "Home",
          style: TextStyle(fontSize: 17, color: Colors.black),
        ),
        backgroundColor: Colors.white,
      ),


      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                height: 150,
                decoration: BoxDecoration(
                  image: const DecorationImage(
                    image: NetworkImage(
                        'https://i.pinimg.com/564x/47/51/43/475143cb05d3571879a8b1f7716d88ef.jpg'),
                    fit: BoxFit.cover,
                  ),
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.red,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const GreyText(
                          text: "Available",
                          textColor: Colors.black,
                          fw: FontWeight.bold),
                      TextButton(
                          onPressed: () {},
                          child: Row(
                            children: const [
                              GreyText(
                                text: "View",
                                textColor: Colors.black,
                              ),
                              Icon(
                                Icons.arrow_forward_ios,
                                color: Colors.black,
                              )
                            ],
                          ))
                    ],
                  ),
                ),
              ),

              const SizedBox(
                height: 320,
               child: ShFoodCard(),
              ),
              
              const SizedBox(
                height: 20,
              ),

              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10)),
                child: const Padding(
                  padding: EdgeInsets.symmetric(vertical: 10),
                  child: GreyText(
                      text: "News",
                      textColor: Colors.black,
                      fw: FontWeight.bold),
                ),
              ),
              
             const SizedBox(
                height: 320,
                child: ShNewsCard(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}


