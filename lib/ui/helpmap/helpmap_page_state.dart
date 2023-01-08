part of 'helpmap_page_cubit.dart';

@immutable
abstract class HelpMapPageState {}

class HelpMapPageInitial extends HelpMapPageState {}
class LoadingReceivers extends HelpMapPageState {}
class Error extends HelpMapPageState {
  final String msg;

  Error(this.msg);
}
class NoReceivers extends HelpMapPageState {}
class ReceivedReceivers extends HelpMapPageState {
  final List<UserModel> receivers;

  ReceivedReceivers(this.receivers);
}


