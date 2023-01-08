import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:helpfeed2/utils/enums.dart';
import 'package:meta/meta.dart';

import '../../../../models/request_model.dart';

part 'home_page_state.dart';

class HomePageCubit extends Cubit<HomePageState> {
  HomePageCubit() : super(HomePageInitial());

  Future<void> fetchRequests() async {


    emit(LoadingRequests());

    CollectionReference refRequests =
    FirebaseFirestore.instance.collection('requests');
    refRequests.where('status', isEqualTo: RequestStatus.raised.name).get().then((value) {
      if(value.size==0) {
        emit(NoRequests());
      }else{
        value.docs.forEach((value){


          print('printing all data--$value');

        });
        debugPrint("Received Data >>>>> ${value.docs[0].get("raisedBy")}");
        debugPrint("Received Data >>>>> ${value.docs[0].get('acceptedBy')}");
        debugPrint("Received Data >>>>> ${value.docs[0].get('description')}");
        debugPrint("Received Data >>>>> ${value.docs[0].get('expireOn')}");
        debugPrint("Received Data >>>>> ${value.docs[0].get('addedOn')}");
        debugPrint("Received Data >>>>> ${value.docs[0].get('pickupLocation')}");
        debugPrint("Received Data >>>>> ${value.docs[0].get('quantity')}");
        debugPrint("Received Data >>>>> ${value.docs[0].get('status')}");
        debugPrint("Received Data >>>>> ${value.docs[0].get('contact')}");
        debugPrint("Received Data >>>>> ${value.docs[0].get('owner')}");
        debugPrint("Received Data >>>>> ${value.docs[0].get('name')}");


        emit(ReceivedRequests(value.docs.map((e) => RequestModel.fromQueryDocumentSnapshot(e,e.id)).toList()));
      }

    }).catchError((error) {
      debugPrint(error);
      emit(Error("Something went wrong !!!"));
    });
  }
}
