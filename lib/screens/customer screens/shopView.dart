import 'package:flutter/material.dart';
import 'package:food_app/components/cusComponents/shopAppBar.dart';
import 'package:food_app/components/cusComponents/shopDetails.dart';

class ShopView extends StatefulWidget {
  const ShopView({super.key});

  @override
  State<ShopView> createState() => _ShopViewState();
}

class _ShopViewState extends State<ShopView> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: ShopAppBar(),
    );
  }
}
