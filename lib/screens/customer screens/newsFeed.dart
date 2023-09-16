import 'package:flutter/material.dart';
import '../../components/cusComponents/newsCard.dart';
import '../../components/cusComponents/shComponents/shNewsCard.dart';
import '../../components/cusComponents/newsCardButton.dart';

class NewsFeed extends StatefulWidget {
  const NewsFeed({Key? key}) : super(key: key);

  @override
  State<NewsFeed> createState() => _NewsFeedState();
}

class _NewsFeedState extends State<NewsFeed> {
  

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
                icon: const Icon(Icons.arrow_back , color: Colors.black),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
          title:const Text(
            "News Feed",
            style: TextStyle(
              color: Colors.black,
              fontSize: 30,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.start,
          ),
          backgroundColor: Colors.white,
        ),
        body:const Padding(
          padding:  EdgeInsets.only(top: 10 , left: 5 , right: 5),
          child:  SizedBox(
                height: 320,
                child:  NewsCard())
        ),
      ),
    );
  }
}
