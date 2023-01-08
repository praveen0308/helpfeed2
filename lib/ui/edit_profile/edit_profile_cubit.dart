import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

import '../../local/app_storage.dart';
import '../../models/user_model.dart';

part 'edit_profile_state.dart';

class EditProfileCubit extends Cubit<EditProfileState> {
  EditProfileCubit() : super(EditProfileInitial());

  Future<void> updateUserProfile(UserModel userModel) async {
    String? email = await AppStorage.getUserId();
    await AppStorage.setName(userModel.name!);
    await AppStorage.setPersonName(userModel.personName!);
    await AppStorage.setWebUrl(userModel.webUrl.toString());
    await AppStorage.setPhoneNumber(userModel.contacts![0]);
    await AppStorage.setDescription(userModel.description!);
    emit(Updating());
    CollectionReference colUsers =
    FirebaseFirestore.instance.collection('users');
    colUsers.doc(email).update({
      "name": userModel.name,
      "personName": userModel.personName,
      "contacts": userModel.contacts,
      "description": userModel.description,
      "webUrl": userModel.webUrl,
    }).then((value) {
      emit(UpdatedSuccessfully());
    }).catchError((error) {
      debugPrint(error);
      emit(Error("Something went wrong!!!"));
    });
  }
}
