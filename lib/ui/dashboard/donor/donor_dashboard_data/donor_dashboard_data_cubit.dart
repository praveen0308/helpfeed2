import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:helpfeed2/utils/enums.dart';
import 'package:meta/meta.dart';

import '../../../../models/user_model.dart';

part 'donor_dashboard_data_state.dart';

class DonorDashboardDataCubit extends Cubit<DonorDashboardDataState> {
  DonorDashboardDataCubit() : super(DonorDashboardDataInitial());

  Future<void> fetchData() async {
    emit(Loading());
    CollectionReference refRequests =
    FirebaseFirestore.instance.collection('users');
    refRequests.where('role', isEqualTo: UserRole.receiver.name).get().then((value) {
      if(value.size==0) {
        emit(NoData());
      }else{
        emit(ReceivedData(value.docs.map((e) => UserModel.fromQSnapshot(e,e.id)).toList()));
      }

    }).catchError((error) {
      debugPrint(error);
      emit(Error("Something went wrong !!!"));
    });
  }
}
