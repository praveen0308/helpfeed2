import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:helpfeed2/models/user_model.dart';
import 'package:meta/meta.dart';

import '../../../local/app_storage.dart';

part 'basic_details_state.dart';

class BasicDetailsCubit extends Cubit<BasicDetailsState> {
  BasicDetailsCubit() : super(BasicDetailsInitial());

  Future<void> addBasicDetails(UserModel userModel) async {

    await AppStorage.setUserId(userModel.email!);
    await AppStorage.setCategory(userModel.category!);
    await AppStorage.setRole(userModel.role!);
    await AppStorage.setName(userModel.name!);
    await AppStorage.setPersonName(userModel.personName!);
    await AppStorage.setWebUrl(userModel.webUrl.toString());
    await AppStorage.setPhoneNumber(userModel.contacts![0]);
    emit(Loading());
    CollectionReference colUsers =
    FirebaseFirestore.instance.collection('users');
    colUsers.doc(userModel.email).update({
      "role": userModel.role,
      "category": userModel.category,
      "name": userModel.name,
      "personName": userModel.personName,
      "contacts": userModel.contacts,
      "images": [],
      "docs": [],
      "description": userModel.description,
      "address":null,
      "webUrl": userModel.webUrl,
    }).then((value) {
      emit(AddedSuccessfully());
    }).catchError((error) {
      debugPrint(error);
      emit(Failed());
    });
  }
}
