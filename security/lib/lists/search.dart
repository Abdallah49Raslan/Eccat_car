import 'package:flutter/material.dart';

import '../core/colors.dart';
import '../core/text_style.dart';

class DataSearchPage extends StatefulWidget {
  @override
  _DataSearchPageState createState() => _DataSearchPageState();
}

class _DataSearchPageState extends State<DataSearchPage> {
  List<String> data = [
    'Battery',
    'Speed',
    'Driver Health',
    'Passenger1',
    'Passenger 2'
  ];
  String _searchText = '';

  @override
  Widget build(BuildContext context) {
    List<String> filteredData = data
        .where((item) => item.toLowerCase().contains(_searchText.toLowerCase()))
        .toList();

    return Scaffold(
      backgroundColor: blackBG,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: backgroundColorDark,
        title: const Text(
          "Data Search",
          style: headline1,
        ),
        iconTheme: IconThemeData(color: whiteText),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              onChanged: (text) {
                setState(() {
                  _searchText = text;
                });
              },
              decoration: InputDecoration(
                hintText: 'Search...',
                hintStyle: headline3,
                suffixIcon: Icon(Icons.search, color: whiteText),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: whiteText),
                  borderRadius: BorderRadius.circular(20),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: whiteText),
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              style: TextStyle(color: whiteText),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: filteredData.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(
                    filteredData[index],
                    style: TextStyle(color: whiteText),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
