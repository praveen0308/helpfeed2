import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'document_screen_state.dart';

class DocumentScreenCubit extends Cubit<DocumentScreenState> {
  DocumentScreenCubit() : super(DocumentScreenInitial());
}
