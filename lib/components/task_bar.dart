import 'package:flutter/material.dart';
import 'package:novel_crawl/models/novel_detail.dart';
import 'package:novel_crawl/screens/readingscreen.dart';

class TaskBar extends StatefulWidget {
  const TaskBar({super.key, required this.novel});
  final TruyenDetail novel;

  @override
  State<TaskBar> createState() => _TaskBarState();
}

class _TaskBarState extends State<TaskBar> {

  TruyenDetail get novel => widget.novel;
  
  //3 button, 1 button icon 'Xuất Ebook', 1 textbutton màu vàng 'Đọc truyện', 1 button icon 'Tải về'

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 60,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,

        children: [
          GestureDetector(
            onTap: () {
              //export novel
            },
            child: Container(
              color: Colors.transparent,
              child: const Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                Icon(Icons.book, color: Colors.white,),
                Text('Ebook', style: TextStyle(color: Colors.white),)
              ],),
            )
          ),
          GestureDetector(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => ReadingScreen(novel: novel, chapter: 1)));
                
              },
              child: Container(
                width: 150,
                height: 40,
                decoration: BoxDecoration(
                    //color: DFD82C
                    color: const Color(0xFFDFD82C),
                    borderRadius: BorderRadius.circular(15)),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.import_contacts,
                      color: Colors.white,
                    ),
                    SizedBox(
                      width: 2,
                    ),
                    Text("Đọc truyện",
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.white))
                  ],
                ),
              ),
            ),
          GestureDetector(
            onTap: () {
              //download novel
            },
            child: Container(
              color: Colors.transparent,
              child: const Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                Icon(Icons.download, color: Colors.white,),
                Text('Tải về', style: TextStyle(color: Colors.white),)
              ],),
            )
          ),
        ],),
    );

  }
}