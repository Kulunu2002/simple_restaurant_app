import 'package:flutter/material.dart';
import 'package:food_app/widgets/myTextField.dart';

class SearchBar extends StatefulWidget {
  const SearchBar({Key? key}) : super(key: key);

  @override
  _SearchBarState createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {
  TextEditingController searchText = TextEditingController();
  bool isSearching = false; 

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 400,
      height: 150,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: MyTextField(
              controller: searchText,
              hintText: "Search...",
              obscureText: false,
              onTap: () {
                setState(() {
                  isSearching = true;
                });
              },
              onChanged: (text) {
                setState(() {
                  isSearching = text.isNotEmpty;
                });
              },
            ),
          ),
          IconButton(
            onPressed: () {
              setState(() {
                if (isSearching) {
                  searchText.clear();
                  isSearching = false;
                } else {
                  isSearching = true;
                }
              });
            },
            icon: Icon(
              isSearching ? Icons.cancel : Icons.search,
              color: isSearching ? Colors.black : Colors.black,
            ),
          ),
        ],
      ),
    );
  }
}
