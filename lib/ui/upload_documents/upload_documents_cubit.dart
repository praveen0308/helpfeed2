import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'upload_documents_state.dart';

class UploadDocumentsCubit extends Cubit<UploadDocumentsState> {
  UploadDocumentsCubit() : super(UploadDocumentsInitial());
}
