import 'dart:io';
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:bloc/bloc.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:meta/meta.dart';

part 'upload_images_state.dart';

class UploadImagesCubit extends Cubit<UploadImagesState> {
  UploadImagesCubit() : super(UploadImagesInitial());

  Future<void> uploadImages(List<File> images) async {
    emit(UploadingImages());

    List<String> _downloadUrls = [];
    try{
      await Future.forEach(images, (File image) async {
        Reference ref = FirebaseStorage.instance
            .ref()
            .child('images')
            .child(basename(image.path));
        final UploadTask uploadTask = ref.putFile(image);
        final TaskSnapshot taskSnapshot = await uploadTask.whenComplete(() {});
        final url = await taskSnapshot.ref.getDownloadURL();
        _downloadUrls.add(url);
      });

      emit(ImageUploaded(_downloadUrls));

    }on Exception catch(e){
      debugPrint(e.toString());
      emit(Error("Something went wrong!!!"));
    }


  }
}
