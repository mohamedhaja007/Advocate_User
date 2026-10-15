class DocumentModel {
  final String id;
  final String title;
  final String fileUrl;
  final String fileType;
  final String uploadDate;
  final String fileSize;

  DocumentModel({
    required this.id,
    required this.title,
    required this.fileUrl,
    required this.fileType,
    required this.uploadDate,
    required this.fileSize,
  });

  factory DocumentModel.fromJson(Map<String, dynamic> json) {
    return DocumentModel(
      id: json['id'] ?? '',
      title: json['title'] ?? '',
      fileUrl: json['file_url'] ?? json['fileUrl'] ?? '',
      fileType: json['file_type'] ?? json['fileType'] ?? 'PDF',
      uploadDate: json['upload_date'] ?? json['uploadDate'] ?? '',
      fileSize: json['file_size'] ?? json['fileSize'] ?? '0 KB',
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'file_url': fileUrl,
        'file_type': fileType,
        'upload_date': uploadDate,
        'file_size': fileSize,
      };
}

class DocumentAnalysisModel {
  final String documentId;
  final String summary;
  final List<String> keyPoints;
  final List<String> potentialRisks;
  final List<String> suggestions;
  final String riskLevel; // High, Medium, Low

  DocumentAnalysisModel({
    required this.documentId,
    required this.summary,
    required this.keyPoints,
    required this.potentialRisks,
    required this.suggestions,
    required this.riskLevel,
  });

  factory DocumentAnalysisModel.fromJson(Map<String, dynamic> json) {
    return DocumentAnalysisModel(
      documentId: json['document_id'] ?? json['documentId'] ?? '',
      summary: json['summary'] ?? '',
      keyPoints: List<String>.from(json['key_points'] ?? json['keyPoints'] ?? []),
      potentialRisks: List<String>.from(json['potential_risks'] ?? json['potentialRisks'] ?? []),
      suggestions: List<String>.from(json['suggestions'] ?? []),
      riskLevel: json['risk_level'] ?? json['riskLevel'] ?? 'Low',
    );
  }

  Map<String, dynamic> toJson() => {
        'document_id': documentId,
        'summary': summary,
        'key_points': keyPoints,
        'potential_risks': potentialRisks,
        'suggestions': suggestions,
        'risk_level': riskLevel,
      };
}
