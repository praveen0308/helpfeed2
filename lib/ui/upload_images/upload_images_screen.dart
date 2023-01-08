import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:helpfeed2/ui/upload_images/upload_images_cubit.dart';

class UploadImagesScreen extends StatefulWidget {
  const UploadImagesScreen({Key? key}) : super(key: key);

  @override
  State<UploadImagesScreen> createState() => _UploadImagesScreenState();
}

class _UploadImagesScreenState extends State<UploadImagesScreen> {
  final List<File> _images = [];

  @override
  void initState() {
    super.initState();
  }

  Future<void> _pickImages() async {
    FilePickerResult? result =
    await FilePicker.platform.pickFiles(allowMultiple: true);

    if (result != null) {
      for (var path in result.paths) {
        _images.add(File(path!));
      }
      setState(() {});
    } else {
      // User canceled the picker
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Pick Images"),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0),
          child: Stack(
            children: [
              Form(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      OutlinedButton(
                          onPressed: () {
                            _pickImages();
                          },
                          child: const Text("Pick Images")),
                      GridView.builder(
                        shrinkWrap: true,
                        gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisSpacing: 0,
                          mainAxisSpacing: 0,
                          crossAxisCount: 3,
                        ),
                        itemCount: _images.length,
                        itemBuilder: (context, index) {
                          return Container(
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                fit: BoxFit.cover,
                                image: FileImage(_images[index]),
                              ),
                            ),
                          );
                        },
                      ),
                    ],
                  )),
              Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child:
                  BlocBuilder<UploadImagesCubit, UploadImagesState>(
                    builder: (context, state) {

                      if(state is UploadingImages){
                        return const Center(child: CircularProgressIndicator(),);
                      }
                      return ElevatedButton(
                          onPressed: () {
                            BlocProvider.of<UploadImagesCubit>(context).uploadImages(_images);
                          }, child: const Text("Upload"));
                    },
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
