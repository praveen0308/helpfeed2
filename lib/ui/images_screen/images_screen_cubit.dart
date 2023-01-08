import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:helpfeed2/models/user_model.dart';
import 'package:meta/meta.dart';

part 'images_screen_state.dart';

class ImagesScreenCubit extends Cubit<ImagesScreenState> {
  ImagesScreenCubit() : super(ImagesScreenInitial());

  Future<void> fetchImages() async {
    emit(Loading());
    User user = FirebaseAuth.instance.currentUser!;
    CollectionReference colUsers =
    FirebaseFirestore.instance.collection('users');
    colUsers.doc(user.email).get().then((snapshot) {
      UserModel userModel = UserModel.fromDSnapshot(snapshot);
      emit(ReceivedImages(userModel.images!.map((e) => e.toString()).toList()));
    }).catchError((error) {
      debugPrint(error);
      emit(Error("Something went wrong !!!"));
    });
  }
}
