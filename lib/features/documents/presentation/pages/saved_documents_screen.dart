import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/widgets/app_card.dart';
import '../../../../core/widgets/app_header.dart';
import '../../../../core/widgets/app_loader.dart';
import '../../../../core/widgets/app_error_view.dart';
import '../../../../core/widgets/app_empty_view.dart';
import '../../../../core/localization/app_localizations.dart';
import '../cubit/document_cubit.dart';

class SavedDocumentsScreen extends StatefulWidget {
  const SavedDocumentsScreen({super.key});

  @override
  State<SavedDocumentsScreen> createState() => _SavedDocumentsScreenState();
}

class _SavedDocumentsScreenState extends State<SavedDocumentsScreen> {
  @override
  void initState() {
    super.initState();
    context.read<DocumentCubit>().loadSavedDocuments();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppHeader(
        title: context.tr('saved_documents'),
        onBackPressed: () => context.pop(),
        actions: [
          IconButton(
            icon: const Icon(Icons.add_rounded),
            onPressed: () => context.push('/document-upload'),
          ),
        ],
      ),
      body: SafeArea(
        child: BlocBuilder<DocumentCubit, DocumentState>(
          builder: (context, state) {
            if (state is DocumentLoading) {
              return const AppLoader(message: 'Loading saved documents...');
            } else if (state is DocumentError) {
              return AppErrorView(
                message: state.message,
                onRetry: () => context.read<DocumentCubit>().loadSavedDocuments(),
              );
            } else if (state is SavedDocumentsLoaded) {
              if (state.documents.isEmpty) {
                return const AppEmptyView(
                  title: 'No Documents Found',
                  message: 'Upload legal documents to get instant AI analysis.',
                  icon: Icons.folder_open_rounded,
                );
              }
              return ListView.separated(
                padding: const EdgeInsets.all(16),
                itemCount: state.documents.length,
                separatorBuilder: (context, index) => const SizedBox(height: 12),
                itemBuilder: (context, index) {
                  final doc = state.documents[index];
                  return AppCard(
                    onTap: () => context.push('/document-analysis', extra: doc.id),
                    child: Row(
                      children: [
                        Container(
                          width: 48,
                          height: 48,
                          decoration: BoxDecoration(
                            color: AppColors.primaryBlue.withAlpha(20),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: const Icon(
                            Icons.picture_as_pdf_rounded,
                            color: AppColors.primaryBlue,
                            size: 24,
                          ),
                        ),
                        const SizedBox(width: 14),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                doc.title,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: AppTextStyles.headingSmall(
                                  color: isDark ? AppColors.white : AppColors.primaryNavy,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                '${doc.uploadDate} • ${doc.fileSize}',
                                style: AppTextStyles.caption(
                                  color: isDark ? AppColors.darkTextSecondary : AppColors.grey,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const Icon(
                          Icons.arrow_forward_ios_rounded,
                          size: 16,
                          color: AppColors.grey,
                        ),
                      ],
                    ),
                  );
                },
              );
            }
            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}
