part of 'document_screen_cubit.dart';

@immutable
abstract class DocumentScreenState {}

class DocumentScreenInitial extends DocumentScreenState {}
class LoadingDocs extends DocumentScreenState {}
class ReceivedDocs extends DocumentScreenState {

}
