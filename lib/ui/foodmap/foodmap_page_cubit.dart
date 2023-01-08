import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';

import '../../local/app_storage.dart';
import '../../models/request_model.dart';
import '../../utils/enums.dart';
import '../../utils/util_methods.dart';

part 'foodmap_page_state.dart';

class FoodMapPageCubit extends Cubit<FoodMapPageState> {
  FoodMapPageCubit() : super(FoodMapPageInitial());

  Future<void> fetchRequests() async {

    double? lat = await AppStorage.getLatitude();
    double? long = await AppStorage.getLongitude();
    emit(LoadingRequests());

    CollectionReference refRequests =
    FirebaseFirestore.instance.collection('requests');
    refRequests.where('status', isEqualTo: RequestStatus.raised.name).get().then((value) {
      if(value.size==0) {
        emit(NoRequests());
      }else{
        var requests = value.docs.map((e) => RequestModel.fromQueryDocumentSnapshot(e,e.id)).toList();
        requests = requests.where((element) => element.expireOn!>DateTime.now().millisecondsSinceEpoch).toList();
        requests.forEach((element) {
          double lat2 = element.pickupLocation!["lat"];
          double long2 = element.pickupLocation!["long"];

          element.distance = UtilMethods.calculateDistance(lat!, long!, lat2, long2);
        });
        emit(ReceivedRequests(requests));

      }

    }).catchError((error) {
      debugPrint(error);
      emit(Error("Something went wrong !!!"));
    });
  }
}
