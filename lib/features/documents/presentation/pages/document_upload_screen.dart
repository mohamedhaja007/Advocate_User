import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/widgets/app_button.dart';
import '../../../../core/widgets/app_header.dart';

class DocumentUploadScreen extends StatefulWidget {
  const DocumentUploadScreen({super.key});

  @override
  State<DocumentUploadScreen> createState() => _DocumentUploadScreenState();
}

class _DocumentUploadScreenState extends State<DocumentUploadScreen> {
  String? _selectedFileName;

  void _onSelectFile() {
    setState(() {
      _selectedFileName = 'Legal_Agreement_Draft.pdf';
    });
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppHeader(
        title: 'Upload Document',
        onBackPressed: () => context.pop(),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  Text(
                    'Upload your legal agreement or notice for instant AI risk evaluation and legal summary.',
                    style: AppTextStyles.bodyMedium(
                      color: isDark ? AppColors.darkTextSecondary : AppColors.grey,
                    ),
                  ),
                  const SizedBox(height: 32),

                  // Upload Box Area
                  GestureDetector(
                    onTap: _onSelectFile,
                    child: Container(
                      height: 200,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: isDark ? AppColors.darkCard : AppColors.lightSurface,
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: AppColors.primaryBlue,
                          width: 1.5,
                        ),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            width: 60,
                            height: 60,
                            decoration: BoxDecoration(
                              color: AppColors.primaryBlue.withAlpha(25),
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(
                              Icons.cloud_upload_rounded,
                              size: 32,
                              color: AppColors.primaryBlue,
                            ),
                          ),
                          const SizedBox(height: 16),
                          Text(
                            _selectedFileName ?? 'Tap to select PDF or image document',
                            style: AppTextStyles.headingSmall(
                              color: isDark ? AppColors.white : AppColors.primaryNavy,
                            ),
                          ),
                          const SizedBox(height: 6),
                          Text(
                            'Supports PDF, DOCX, PNG, JPG up to 15MB',
                            style: AppTextStyles.caption(
                              color: AppColors.grey,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              AppButton(
                text: 'Start AI Analysis',
                onPressed: _selectedFileName == null
                    ? null
                    : () {
                        context.push('/document-analysis', extra: 'doc_1');
                      },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
