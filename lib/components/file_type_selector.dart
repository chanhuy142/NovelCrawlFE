

import 'package:flutter/material.dart';
import 'package:novel_crawl/service/api_service.dart';

class FileTypeSelector extends StatefulWidget {
  const FileTypeSelector({super.key, required this.onFileTypeChanged});
  final Function(String) onFileTypeChanged;

  @override
  State<FileTypeSelector> createState() => _FileTypeSelectorState();
}

class _FileTypeSelectorState extends State<FileTypeSelector> {
  String? _chosenValue = '';

  APIService apiService = APIService();

  List<String> fileTypes = [];

  @override
  void initState() {
    super.initState();
    apiService.getFileTypes().then((value) {
      setState(() {
        fileTypes = value;
        if(fileTypes.isNotEmpty){
          _chosenValue = fileTypes[0];
          widget.onFileTypeChanged(fileTypes[0]);
        }
      });
    });
    
  }


  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      value: _chosenValue,
      //elevation: 5,
      style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w600),

      items: fileTypes.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
      hint: Text(
        "Please choose a file type",
        style: TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.w600),
      ),
      onChanged: (String? value) {
        setState(() {
          _chosenValue = value;
          widget.onFileTypeChanged(value!);
        });
      },
    );
  }
}