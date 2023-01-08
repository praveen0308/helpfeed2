import 'dart:io';

import 'package:flutter/material.dart';
import 'package:helpfeed2/utils/extension_methods.dart';
import 'package:path/path.dart';

class DocumentView extends StatefulWidget {
  final File file;
  const DocumentView({Key? key, required this.file}) : super(key: key);

  @override
  State<DocumentView> createState() => _DocumentViewState();
}

class _DocumentViewState extends State<DocumentView> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(

        children: [
          Container(
            color: Colors.red,
            child: Center(
              child: Text(extension(widget.file.path)),
            ),

          ),
          Expanded(child: Column(
            children: [
              Text(basename(widget.file.path)),
              Text(widget.file.getFileSize())
            ],
          )),

        ],
      ),
    );
  }
}
