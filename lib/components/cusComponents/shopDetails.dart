import 'package:flutter/material.dart';
import 'package:food_app/components/cusComponents/foodCard.dart';

class ShopDetails extends StatelessWidget {
  ShopDetails({Key? key}) : super(key: key);

  List<Tab> myTabs = <Tab>[
    const Tab(text: 'Featured'),
    const Tab(text: 'Popular'),
    const Tab(text: 'New'),
  ];

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: myTabs.length,
      child: Scaffold(
        body: Column(
          children: [
            Container(
              color: Color.fromARGB(173, 255, 255, 255),
              height: 50,
              width: MediaQuery.of(context).size.width,
              child: Center(
                child: TabBar(
                  labelStyle: const TextStyle(fontSize: 20),
                  labelColor: Colors.black,
                  unselectedLabelColor: Colors.grey,
                  indicatorColor: Colors.grey,
                  indicatorPadding: const EdgeInsets.all(9),
                  tabs: myTabs,
                  isScrollable: true,
                ),
              ),
            ),
            const Expanded(
              child: TabBarView(
                children: <Widget>[
                  Center(child: FoodCard()),
                  Center(child: Text('Tab 2 Content')),
                  Center(child: Text('Tab 3 Content')),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
