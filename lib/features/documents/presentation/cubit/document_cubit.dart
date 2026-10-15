import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/models/document_model.dart';
import '../../data/document_repository.dart';

abstract class DocumentState extends Equatable {
  @override
  List<Object?> get props => [];
}

class DocumentInitial extends DocumentState {}
class DocumentLoading extends DocumentState {}
class SavedDocumentsLoaded extends DocumentState {
  final List<DocumentModel> documents;
  SavedDocumentsLoaded(this.documents);
  @override
  List<Object?> get props => [documents];
}
class DocumentAnalysisLoaded extends DocumentState {
  final DocumentAnalysisModel analysis;
  DocumentAnalysisLoaded(this.analysis);
  @override
  List<Object?> get props => [analysis];
}
class DocumentError extends DocumentState {
  final String message;
  DocumentError(this.message);
  @override
  List<Object?> get props => [message];
}

class DocumentCubit extends Cubit<DocumentState> {
  final DocumentRepository documentRepository;

  DocumentCubit({required this.documentRepository}) : super(DocumentInitial());

  Future<void> loadSavedDocuments() async {
    emit(DocumentLoading());
    try {
      final docs = await documentRepository.getSavedDocuments();
      emit(SavedDocumentsLoaded(docs));
    } catch (e) {
      emit(DocumentError(e.toString()));
    }
  }

  Future<void> analyzeDocument(String documentId) async {
    emit(DocumentLoading());
    try {
      final analysis = await documentRepository.analyzeDocument(documentId);
      emit(DocumentAnalysisLoaded(analysis));
    } catch (e) {
      emit(DocumentError(e.toString()));
    }
  }
}
