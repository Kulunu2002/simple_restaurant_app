import 'package:flutter/material.dart';
import 'package:food_app/components/cusComponents/newsCardButton.dart';
import 'package:food_app/components/cusComponents/pinShop.dart';
import 'package:food_app/widgets/searchBar.dart';
import 'package:food_app/components/cusComponents/shopCard.dart';

class HomeComponents extends StatefulWidget {
  const HomeComponents({super.key});

  @override
  State<HomeComponents> createState() => _HomeComponentsState();
}

class _HomeComponentsState extends State<HomeComponents> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.white,
            actions: const [SearchBar()],
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.only(left: 10, right: 10, top: 10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text(
                    "News Feed",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    height: 300,
                    child: NewsCardButton(),
                  ),
                  SizedBox(height: 15),
                  Text("Shops",
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      )),
                  ShopCard(),
                ],
              ),
            ),
          )),
    );
  }
}
