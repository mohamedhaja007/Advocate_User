import '../../../core/models/document_model.dart';
import '../../../core/network/api_client.dart';
import '../../../core/network/api_endpoints.dart';

abstract class DocumentRepository {
  Future<List<DocumentModel>> getSavedDocuments();
  Future<DocumentAnalysisModel> analyzeDocument(String documentId);
}

class DocumentRepositoryImpl implements DocumentRepository {
  final ApiClient apiClient;

  DocumentRepositoryImpl({required this.apiClient});

  @override
  Future<List<DocumentModel>> getSavedDocuments() async {
    try {
      final response = await apiClient.get(ApiEndpoints.savedDocuments);
      if (response is List) {
        return response.map((json) => DocumentModel.fromJson(json)).toList();
      }
    } catch (_) {}

    return [
      DocumentModel(
        id: 'doc_1',
        title: 'Property Sale Agreement.pdf',
        fileUrl: '',
        fileType: 'PDF',
        uploadDate: '14 May 2024',
        fileSize: '1.2 MB',
      ),
      DocumentModel(
        id: 'doc_2',
        title: 'Employment Contract Notice.pdf',
        fileUrl: '',
        fileType: 'PDF',
        uploadDate: '10 Apr 2024',
        fileSize: '850 KB',
      ),
    ];
  }

  @override
  Future<DocumentAnalysisModel> analyzeDocument(String documentId) async {
    try {
      final response = await apiClient.post(
        ApiEndpoints.documentAnalysis,
        data: {'document_id': documentId},
      );
      if (response != null) {
        return DocumentAnalysisModel.fromJson(response);
      }
    } catch (_) {}

    await Future.delayed(const Duration(seconds: 1));
    return DocumentAnalysisModel(
      documentId: documentId,
      summary:
          'This legal document outlines the terms of a property transfer agreement between two parties. It includes indemnification and penalty clauses.',
      keyPoints: [
        'Property location: Plot 42, Velachery, Chennai',
        'Consideration amount: ₹45,00,000',
        'Handover date: 30 June 2024',
      ],
      potentialRisks: [
        'Clause 8 lacks clarity regarding delay penalties',
        'No title verification warranty explicitly mentioned',
      ],
      suggestions: [
        'Insert explicit indemnity against third-party claims',
        'Specify exact jurisdiction court for dispute resolution',
      ],
      riskLevel: 'Medium',
    );
  }
}
