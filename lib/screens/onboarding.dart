// ignore_for_file: file_names, prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';

class OnBoarding extends StatelessWidget {
  const OnBoarding({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'lib/images/onboard.png',
              width: 500,
              height: 500,
            ),
            Text("NovelCrawl",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 30,
                    fontWeight: FontWeight.bold)),
            Text("Tìm đọc tiểu thuyết yêu thích một ",
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 20,
                )),
            //cách dễ dàng và tiện lợi với NovelCrawl
            Text("cách dễ dàng và tiện lợi với ",
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 20,
                )),
            Text("NovelCrawl ",
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 20,
                )),
            SizedBox(
              height: 20,
            ),
            GestureDetector(
              onTap: () {
                //pop onboarding screen
                Navigator.pushReplacementNamed(context, '/navigation');
              },
              child: Container(
                width: double.infinity,
                margin: EdgeInsets.symmetric(horizontal: 20),
                height: 50,
                decoration: BoxDecoration(
                    //color: DFD82C
                    color: Color(0xFFDFD82C),
                    borderRadius: BorderRadius.circular(10)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.search,
                      color: Colors.white,
                    ),
                    SizedBox(
                      width: 2,
                    ),
                    Text("Bắt đầu",
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.white))
                  ],
                ),
              ),
            ),
          ],
        ));
  }
}
