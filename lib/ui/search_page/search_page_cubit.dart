import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

import '../../models/user_model.dart';

part 'search_page_state.dart';

class SearchPageCubit extends Cubit<SearchPageState> {
  SearchPageCubit() : super(SearchPageInitial());


  Future<void> fetchUsers(String query) async {
    emit(Searching());
    CollectionReference refRequests =
    FirebaseFirestore.instance.collection('users');
    refRequests.where("name", isGreaterThanOrEqualTo: query).where("name", isLessThanOrEqualTo: "$query\uf7ff").get().then((value) {
      if(value.size==0) {
        emit(NoUsersFound());
      }else{


        emit(ReceivedUsers(value.docs.map((e) => UserModel.fromQSnapshot(e,e.id)).toList()));
      }

    }).catchError((error) {
      debugPrint(error);
      emit(Error("Something went wrong !!!"));
    });
  }
}
