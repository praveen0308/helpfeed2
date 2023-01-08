import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:helpfeed2/local/app_storage.dart';

import '../../../../models/request_model.dart';

part 'history_page_state.dart';

class HistoryPageCubit extends Cubit<HistoryPageState> {
  HistoryPageCubit() : super(HistoryPageInitial());

  Future<void> fetchRequests() async {
    String? role = await AppStorage.getRole();
    debugPrint("Role>>> $role");
    String userId = FirebaseAuth.instance.currentUser!.email!;
    emit(Loading());

    CollectionReference refRequests =
        FirebaseFirestore.instance.collection('requests');
    if (role == "receiver") {
      refRequests.where('acceptedBy', isEqualTo: userId).get().then((value) {
        if (value.size == 0) {
          emit(NoHistory());
        } else {
          var requests = value.docs
              .map((e) => RequestModel.fromQueryDocumentSnapshot(e, e.id))
              .toList();
         /* requests.forEach((element) {
            var diff = element.expireOn!-DateTime.now().millisecondsSinceEpoch;
            if(diff<=0){
              element.status = "expired";
            }

          });*/
          emit(ReceivedRequests(requests));
        }
      }).catchError((error) {
        debugPrint(error);
        emit(Error("Something went wrong !!!"));
      });
    } else {
      refRequests.where('raisedBy', isEqualTo: userId).get().then((value) {
        if (value.size == 0) {
          emit(NoHistory());
        } else {
          var requests = value.docs
              .map((e) => RequestModel.fromQueryDocumentSnapshot(e, e.id))
              .toList();
          requests.forEach((element) {
            var diff = element.expireOn!-DateTime.now().millisecondsSinceEpoch;
            if(diff<=0){
              element.status = "expired";
            }

          });
          emit(ReceivedRequests(requests));
        }
      }).catchError((error) {
        debugPrint(error);
        emit(Error("Something went wrong !!!"));
      });
    }
  }
}
