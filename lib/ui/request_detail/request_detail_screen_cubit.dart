import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:helpfeed2/models/request_model.dart';
import 'package:helpfeed2/utils/enums.dart';
import 'package:meta/meta.dart';

part 'request_detail_screen_state.dart';

class RequestDetailScreenCubit extends Cubit<RequestDetailScreenState> {
  RequestDetailScreenCubit() : super(RequestDetailScreenInitial());

  Future<void> acceptRequest(String requestId) async {
    String userID = FirebaseAuth.instance.currentUser!.email!;
    emit(Accepting());
    CollectionReference requestRef =
    FirebaseFirestore.instance.collection('requests');
    requestRef.doc(requestId).update({"status":RequestStatus.accepted.name,"acceptedBy":userID}).then((value) {
      emit(AcceptedSuccessfully());
    }).catchError((error) {
      debugPrint(error);
      emit(Error("Something went wrong !!!"));
    });
  }

  Future<void> getRequestById(String requestId) async {
    emit(Accepting());
    CollectionReference requestRef =
    FirebaseFirestore.instance.collection('requests');
    requestRef.doc(requestId).get().then((value) {
      emit(ReceivedDetail(RequestModel.fromMap(value.data() as Map<String,dynamic>, value.id)));
    }).catchError((error) {
      debugPrint(error);
      emit(Error("Something went wrong !!!"));
    });
  }
}
