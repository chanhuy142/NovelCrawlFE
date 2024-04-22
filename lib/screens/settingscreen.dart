import 'package:flutter/material.dart';

class SettingPage extends StatelessWidget {
  const SettingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.black,
      body: Padding(padding: //top padding
            EdgeInsets.only(top: 35),
        child: 
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Nguồn Truyện', 
                style: TextStyle(
                  color: Color(0xFF83899F),
                  fontSize: 20,
                  fontWeight: FontWeight.normal,
                ),
              ),
              Row(
                children: [
                  Text('Màu sắc', 
                    style: TextStyle(
                      color: Color(0xFF83899F),
                      fontSize: 20,
                      fontWeight: FontWeight.normal
                    ),
                  ),
                  
                ],
              )
            ],

          )
          )
    );
  }
}
