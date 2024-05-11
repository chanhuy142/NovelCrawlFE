import 'package:flutter/material.dart';
import 'package:novel_crawl/models/novel_detail.dart';
import 'package:novel_crawl/screens/novelinfoscreen.dart';
import 'package:novel_crawl/service/file_service.dart';

class NovelCard extends StatefulWidget {
  NovelCard({super.key, required this.novelDetail,required this.isOffline});
  final TruyenDetail novelDetail;
  final bool isOffline;

  @override
  State<NovelCard> createState() => _NovelCardState();
}

class _NovelCardState extends State<NovelCard> {
  late Image image = Image.network(widget.novelDetail.cover ?? '', fit: BoxFit.cover);
  @override
  void initState() {
    // TODO: implement initState
    FileService.instance.getNovelImage(widget.novelDetail.tenTruyen).then((value) {
      setState(() {
        if(value != null){
          image = Image.file(value, fit: BoxFit.cover);
        }
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        //message scaffold
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => NovelInfo(novelDetail: widget.novelDetail, isOffline: widget.isOffline,))
        );

        
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
              child: Container(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: image
            ),
          )),
          Container(
            margin: const EdgeInsets.only(top: 5),
            child: Center(
              child: Text(
                widget.novelDetail.tenTruyen,
                style: const TextStyle(color: Colors.white, fontSize: 16 , height: 1, fontFamily: 'Montserrat', fontWeight: FontWeight.bold),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
           Container(
            margin: const EdgeInsets.only(top: 5),
             child: Center(
              child: Text(
                widget.novelDetail.author,
                style: const TextStyle(color: Colors.white, height: 1, fontFamily: 'Montserrat', fontStyle: FontStyle.italic),
                overflow: TextOverflow.ellipsis,
              ),
                       ),
           ),
        ],
      ),
    );
  }
}
