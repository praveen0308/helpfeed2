import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:helpfeed2/models/address_model.dart';
import 'package:meta/meta.dart';

import '../../local/app_storage.dart';

part 'my_address_state.dart';

class MyAddressCubit extends Cubit<MyAddressState> {
  MyAddressCubit() : super(MyAddressInitial());

  Future<void> storeAddressDetails(AddressModel addressModel) async {


    emit(Loading());
    User user = FirebaseAuth.instance.currentUser!;
    await AppStorage.storeAddress(addressModel);
    CollectionReference colUsers =
    FirebaseFirestore.instance.collection('users');
    colUsers.doc(user.email).update({
      "address": addressModel.toMap(),
    }).then((value) {
      emit(StoredSuccessfully());
    }).catchError((error) {
      debugPrint(error);
      emit(Error("Something went wrong !!!"));
    });
  }
}
