part of 'foodmap_page_cubit.dart';

@immutable
abstract class FoodMapPageState {}

class FoodMapPageInitial extends FoodMapPageState {}
class LoadingRequests extends FoodMapPageState {}
class Error extends FoodMapPageState {
  final String msg;

  Error(this.msg);
}
class NoRequests extends FoodMapPageState {}
class ReceivedRequests extends FoodMapPageState {
  final List<RequestModel> requests;

  ReceivedRequests(this.requests);
}

