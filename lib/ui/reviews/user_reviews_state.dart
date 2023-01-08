part of 'user_reviews_cubit.dart';

@immutable
abstract class UserReviewsState {}

class UserReviewsInitial extends UserReviewsState {}
class LoadingReviews extends UserReviewsState {}
class NoReviews extends UserReviewsState {}
class Error extends UserReviewsState {
  final String msg;

  Error(this.msg);
}
class ReceivedReviews extends UserReviewsState {
  final List<ReviewModel> reviews;

  ReceivedReviews(this.reviews);

}
