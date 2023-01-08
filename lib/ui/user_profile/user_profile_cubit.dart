import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:helpfeed2/models/user_model.dart';

part 'user_profile_state.dart';

class UserProfileCubit extends Cubit<UserProfileState> {
  UserProfileCubit() : super(UserProfileInitial());

  Future<void> fetchUserDetail(String userId) async {
    emit(LoadingProfile());
    CollectionReference usersRef =
        FirebaseFirestore.instance.collection('users');

    CollectionReference requestsRef =
        FirebaseFirestore.instance.collection('requests');
    usersRef.doc(userId).get().then((value) {
      UserModel userModel = UserModel.fromDSnapshot(value);

      if (userModel.role == "donor") {
        requestsRef.where("raisedBy", isEqualTo: userId).get().then((counts) {
          userModel.donationCount = counts.docs.length;
          emit(ReceivedUserDetails(userModel));
        }).catchError((error) {
          debugPrint(error);
          emit(Error("Something went wrong !!!"));
        });
      }

      emit(ReceivedUserDetails(userModel));
    }).catchError((error) {
      debugPrint(error);
      emit(Error("Something went wrong !!!"));
    });
  }
}
