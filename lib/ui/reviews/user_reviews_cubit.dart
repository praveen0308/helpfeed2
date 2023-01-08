import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

import '../../models/review_model.dart';

part 'user_reviews_state.dart';

class UserReviewsCubit extends Cubit<UserReviewsState> {
  UserReviewsCubit() : super(UserReviewsInitial());

  Future<void> fetchReviews() async {
    emit(LoadingReviews());

    CollectionReference refRequests =
    FirebaseFirestore.instance.collection('reviews');
    refRequests.orderBy("addedOn",descending: true).get().then((value) {
      if (value.size == 0) {
        emit(NoReviews());
      } else {
        var requests = value.docs
            .map((e) => ReviewModel.fromQSnapshot(e, e.id))
            .toList();

        emit(ReceivedReviews(requests));
      }
    }).catchError((error) {
      debugPrint(error);
      emit(Error("Something went wrong !!!"));
    });
  }
}
