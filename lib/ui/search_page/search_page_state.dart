part of 'search_page_cubit.dart';

@immutable
abstract class SearchPageState {}

class SearchPageInitial extends SearchPageState {}
class Searching extends SearchPageState {}
class NoUsersFound extends SearchPageState {}
class Error extends SearchPageState {
  final String msg;

  Error(this.msg);
}
class ReceivedUsers extends SearchPageState {
  final List<UserModel> users;

  ReceivedUsers(this.users);
}
