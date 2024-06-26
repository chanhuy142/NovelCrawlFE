import 'package:flutter/material.dart';
import 'package:novel_crawl/models/novel.dart';
import 'package:novel_crawl/views/screens/novelinfoscreen.dart';
import 'package:novel_crawl/controllers/service/file_service.dart';

class NovelCard extends StatefulWidget {
  const NovelCard(
      {super.key, required this.novelDetail, required this.isOffline, required this.onRefreshGridView});
  final Novel novelDetail;
  final bool isOffline;
  final Function() onRefreshGridView;

  @override
  State<NovelCard> createState() => _NovelCardState();
}

class _NovelCardState extends State<NovelCard> {
  late Image image =
      Image.network(widget.novelDetail.cover ?? '', fit: BoxFit.cover);

  void deleteNovel(){
    showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: const Text('Delete'),
                content: const Text('Do you want to delete this novel?'),
                actions: [
                  TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text('Cancel')),
                  TextButton(
                      onPressed: () {
                        FileService.instance
                            .deleteNovel(widget.novelDetail.name)
                            .then((value) {
                          if (value) {
                            ScaffoldMessenger.of(context).showSnackBar(
                                 SnackBar(
                                    content: Text(
                                        '${widget.novelDetail.name} deleted')));
                            widget.onRefreshGridView();
                            
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                                 SnackBar(
                                    content: Text(
                                        'Failed to delete ${widget.novelDetail.name}')));
                          }
                        });
                        Navigator.pop(context);
                      },
                      child: const Text('Delete'))
                ],
              );
            });
  }
  @override
  void initState() {
    // TODO: implement initState
    if (widget.isOffline) {
      FileService.instance.getNovelImage(widget.novelDetail.name).then((value) {
        setState(() {
          if (value != null) {
            image = Image.file(value, fit: BoxFit.cover);
          }
        });
      });
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        //message scaffold
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => NovelInfo(
                      novelDetail: widget.novelDetail,
                      isOffline: widget.isOffline,
                    )));
      },
      onLongPress: () {
        //show popup menu to delete
        if(widget.isOffline){
          deleteNovel();
          
        }
        
      } ,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
              child: Container(
            child: ClipRRect(
                borderRadius: BorderRadius.circular(10), child: image),
          )),
          Container(
            margin: const EdgeInsets.only(top: 5),
            child: Center(
              child: Text(
                widget.novelDetail.name,
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    height: 1,
                    fontFamily: 'Montserrat',
                    fontWeight: FontWeight.bold),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(top: 5),
            child: Center(
              child: Text(
                widget.novelDetail.author,
                style: const TextStyle(
                    color: Colors.white,
                    height: 1,
                    fontFamily: 'Montserrat',
                    fontStyle: FontStyle.italic),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
