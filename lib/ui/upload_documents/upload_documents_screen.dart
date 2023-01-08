import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

class UploadDocumentsScreen extends StatefulWidget {
  const UploadDocumentsScreen({Key? key}) : super(key: key);

  @override
  State<UploadDocumentsScreen> createState() => _UploadDocumentsScreenState();
}

class _UploadDocumentsScreenState extends State<UploadDocumentsScreen> {
  List<PlatformFile> _docs = [];

  @override
  void initState() {
    super.initState();
  }

  Future<void> _pickDocuments() async {
    FilePickerResult? result =
        await FilePicker.platform.pickFiles(allowMultiple: true);

    if (result != null) {
      for (var file in result.files) {
        _docs.add(file);
      }
      setState(() {});
    } else {
      // User canceled the picker
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
        child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        OutlinedButton(
            onPressed: () {
              _pickDocuments();
            },
            child: const Text("Pick Documents")),
        ListView.builder(
          shrinkWrap: true,
          itemBuilder: (context, index) {
            PlatformFile doc = _docs[index];
            return Container(
              child: Row(
                children: [
                  Text(doc.name),
                ],
              ),
            );
          },
          itemCount: _docs.length,
        )
      ],
    ));
  }
}
