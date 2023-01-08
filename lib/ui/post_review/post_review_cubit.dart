import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:helpfeed2/local/app_storage.dart';
import 'package:helpfeed2/models/review_model.dart';
import 'package:meta/meta.dart';

part 'post_review_state.dart';

class PostReviewCubit extends Cubit<PostReviewState> {
  PostReviewCubit() : super(PostReviewInitial());

  Future<void> addReview(ReviewModel review) async {

    String? email = await AppStorage.getUserId();
    String? name = await AppStorage.getName();
    review.name = name;
    review.addedBy = email;
    emit(PostingReview());

    CollectionReference refRequests =
    FirebaseFirestore.instance.collection('reviews');
    refRequests.add(review.toMap()).then((value) {
      emit(PostedSuccessfully());
    }).catchError((error) {
      debugPrint(error);
      emit(Error("Something went wrong !!!"));
    });
  }
}
