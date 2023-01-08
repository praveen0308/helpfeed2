part of 'post_review_cubit.dart';

@immutable
abstract class PostReviewState {}

class PostReviewInitial extends PostReviewState {}
class PostingReview extends PostReviewState {}
class PostedSuccessfully extends PostReviewState {}
class Error extends PostReviewState {
  final String msg;

  Error(this.msg);
}
