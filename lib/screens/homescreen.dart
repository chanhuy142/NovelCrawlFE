// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';

import 'package:novel_crawl/components/novel_card.dart';
import 'package:novel_crawl/models/library.dart';
import 'package:novel_crawl/models/novel_detail.dart';
//import api service
import 'package:novel_crawl/service/api_service.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  //get library from api service
  final APIService apiService = APIService();
  Library library = Library(truyenDetail: []);

  List<TruyenDetail> resultnovels = [];
//search function
  void search(String value) {
    if (value.isEmpty) {
      setState(() {
        resultnovels = library.truyenDetail;
      });
    } else {
      setState(() {
        resultnovels = library.truyenDetail
            .where((element) =>
                element.tenTruyen.toLowerCase().contains(value.toLowerCase()))
            .toList();
      });
    }
  }

  //on init
  @override
  void initState() {
    resultnovels = library.truyenDetail;
    
    //get api service
    apiService.getNovelDetails().then((value) {
      setState(() {
        library = value;
        resultnovels = library.truyenDetail;
      });
      
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //backgroundColor 000000
      backgroundColor: Color(0xFF000000),

      body: Padding(
        padding: //top padding
            EdgeInsets.only(top: 35),
        child: Column(
          children: [
            //Header: Search bar and filter icon
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                //Search bar

                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: SizedBox(
                      height: 50,
                      child: TextField(
                        onChanged: (value) => search(value),
                        style: TextStyle(color: Color(0xFF83899F)),
                        decoration: InputDecoration(
                          isDense: true, // Added this
                          contentPadding: EdgeInsets.symmetric(horizontal: 20),
                          hintText: "Tìm kiếm",
                          hintStyle: TextStyle(color: Color(0xFF83899F)),

                          filled: true,
                          fillColor: Color(0xFF2A2D3E),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide: BorderSide(color: Color(0xFF2A2D3E)),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide: BorderSide(color: Color(0xFF2A2D3E)),
                          ),
                          suffixIcon: Icon(
                            Icons.search,
                            size: 30,
                            color: Color(0xFFDFD82C),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                //filter icon
                Padding(
                  padding: const EdgeInsets.only(right: 12.0),
                  child: Icon(Icons.menu, color: Color(0xFFDFD82C), size: 40),
                ),
              ],
            ),
            //Truyện HOT
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Truyện HOT",
                  style: TextStyle(
                      color: Color(0xFF83899F),
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                ),
                Icon(
                  Icons.whatshot,
                  color: Color(0xFFDFD82C),
                )
              ],
            ),
            SizedBox(
              height: 12,
            ),
            //GridView
            Expanded(
              child: GridView.builder(
                shrinkWrap: true,
                itemCount: resultnovels.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  childAspectRatio: 2 / 3,
                ),
                itemBuilder: (context, index) {
                  return NovelCard(
                    novelDetail: resultnovels[index],
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
