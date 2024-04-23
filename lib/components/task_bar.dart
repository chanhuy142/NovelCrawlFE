import 'package:flutter/material.dart';
import 'package:novel_crawl/models/novel_detail.dart';

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
    return Container(
      height: 100,
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
              child: Column(children: [
                Icon(Icons.book, color: Colors.white,),
                Text('Xuất Ebook', style: TextStyle(color: Colors.white),)
              ],),
            )
          ),
          GestureDetector(
              onTap: () {
                
                
              },
              child: Container(
                width: 150,
                margin: EdgeInsets.all(10),
                height: 40,
                decoration: BoxDecoration(
                    //color: DFD82C
                    color: Color(0xFFDFD82C),
                    borderRadius: BorderRadius.circular(15)),
                child: Row(
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
          ElevatedButton(
            onPressed: () {
              //download novel
            }, 
            child: 
            Column(children: [
              Icon(Icons.download),
              Text('Tải về', style: TextStyle(color: Colors.white),)
            ],)
            ),
        ],),
    );

  }
}