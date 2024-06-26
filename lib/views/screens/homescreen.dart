// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:novel_crawl/models/library.dart';
import 'package:novel_crawl/models/novel.dart';
//import api service
import 'package:novel_crawl/controllers/service/api_service.dart';
import 'package:novel_crawl/controllers/service/file_service.dart';

import '../components/novel_card_grid_view.dart';
import '../../controllers/service/state_service.dart';
import '../../controllers/util/search_standardize.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  //get library from api service
  final APIService apiService = APIService();
  static Library library = Library(novels: []);
  static bool isLoading = false;
  final StateService stateService = StateService.instance;
  //text controller
  final TextEditingController _searchController = TextEditingController();
  List<Novel> resultnovels = [];
//search function
  void oldsearch(String value) {
    if (value.isEmpty) {
      setState(() {
        resultnovels = library.novels;
      });
    } else {
      setState(() {
        resultnovels = library.novels
            .where((element) =>
                element.name.toLowerCase().contains(value.toLowerCase()))
            .toList();
      });
    }
  }

  void search(String value) {
    if (!isLoading) {
      if (value.isEmpty) {
        setState(() {
          resultnovels = library.novels;
        });
      } else {
        value = SearchStandardize.standardize(value);
        print(value);
        setState(() {
          isLoading = true;
        });
        APIService().getSearchedNovelDetails(value).then((result) {
          setState(() {
            resultnovels = result.novels;
            isLoading = false;
          });
        }).catchError((onError) {
          print(onError.toString());
          setState(() {
            isLoading = false;
          });
        });
      }
    }
  }

  void loadNovelDetails() {
    if (!isLoading) {
      //get api service
      setState(() {
        isLoading = true;
      });
      apiService.getNovelDetails().then((value) {
        library.copyFrom(value);
        print(library.novels.length);
        if (mounted) {
          setState(() {
            resultnovels = library.novels;
            isLoading = false;
          });
        } else {
          resultnovels = library.novels;
          isLoading = false;
        }
      });
    }
  }

  //on init
  @override
  void initState() {
    resultnovels = library.novels;
    if (library.novels.isEmpty) {
      loadNovelDetails();
    }

    stateService.checkSourcesInDB();
    FileService.instance.init();
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
                        controller: _searchController,
                        onSubmitted: (value) => search(
                            value), //this will handle the search logic, change here
                        style: TextStyle(color: Color(0xFF83899F)),
                        decoration: InputDecoration(
                          isDense: true, // Added this
                          contentPadding: EdgeInsets.symmetric(horizontal: 20),
                          hintText: "Nhập tên hoặc tác giả cần tìm",
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
                          suffixIcon: GestureDetector(
                            onTap: () {
                              search(_searchController.text);
                              FocusScope.of(context).unfocus();
                            },
                            child: Icon(
                              Icons.search,
                              size: 30,
                              color: Color(0xFFDFD82C),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
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
            isLoading
                ? SizedBox(
                    width: 50,
                    height: 50,
                    child: Center(
                      child: CircularProgressIndicator(
                        backgroundColor: Colors.black,
                      ),
                    ),
                  )
                : NovelCardGridView(
                    novelsList: resultnovels,
                    isOffline: false,
                    onRefreshGridView: loadNovelDetails,
                  )
          ],
        ),
      ),
    );
  }
}
