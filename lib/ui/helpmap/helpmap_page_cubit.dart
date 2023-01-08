import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:helpfeed2/models/user_model.dart';
import 'package:meta/meta.dart';

import '../../models/request_model.dart';

part 'helpmap_page_state.dart';

class HelpMapPageCubit extends Cubit<HelpMapPageState> {
  HelpMapPageCubit() : super(HelpMapPageInitial());

  Future<void> fetchReceivers() async {
    emit(LoadingReceivers());
    CollectionReference refRequests =
    FirebaseFirestore.instance.collection('users');
    refRequests.where('role', isEqualTo: "receiver").get().then((value) {
      if(value.size==0) {
        emit(NoReceivers());
      }else{
        emit(ReceivedReceivers(value.docs.map((e) => UserModel.fromQSnapshot(e,e.id)).toList()));
      }

    }).catchError((error) {
      debugPrint(error);
      emit(Error("Something went wrong !!!"));
    });
  }
}
