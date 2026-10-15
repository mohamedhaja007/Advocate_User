import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/widgets/app_card.dart';
import '../../../../core/widgets/app_header.dart';
import '../../../../core/widgets/app_loader.dart';
import '../../../../core/widgets/app_error_view.dart';
import '../../../../core/widgets/app_status_badge.dart';
import '../../../../core/localization/app_localizations.dart';
import '../cubit/document_cubit.dart';

class DocumentAnalysisScreen extends StatefulWidget {
  final String documentId;

  const DocumentAnalysisScreen({
    super.key,
    required this.documentId,
  });

  @override
  State<DocumentAnalysisScreen> createState() => _DocumentAnalysisScreenState();
}

class _DocumentAnalysisScreenState extends State<DocumentAnalysisScreen> {
  @override
  void initState() {
    super.initState();
    context.read<DocumentCubit>().analyzeDocument(widget.documentId);
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppHeader(
        title: 'Document Analysis',
        onBackPressed: () => context.pop(),
      ),
      body: SafeArea(
        child: BlocBuilder<DocumentCubit, DocumentState>(
          builder: (context, state) {
            if (state is DocumentLoading) {
              return const AppLoader(message: 'AI is analyzing your legal document...');
            } else if (state is DocumentError) {
              return AppErrorView(
                message: state.message,
                onRetry: () =>
                    context.read<DocumentCubit>().analyzeDocument(widget.documentId),
              );
            } else if (state is DocumentAnalysisLoaded) {
              final analysis = state.analysis;

              return SingleChildScrollView(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Risk Level Banner Card
                    AppCard(
                      color: isDark ? AppColors.darkCard : AppColors.lightSurface,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                context.tr('risk_level'),
                                style: AppTextStyles.caption(color: AppColors.grey),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                '${analysis.riskLevel} Risk Detected',
                                style: AppTextStyles.headingSmall(
                                  color: isDark ? AppColors.white : AppColors.primaryNavy,
                                ),
                              ),
                            ],
                          ),
                          AppStatusBadge(
                            statusText: analysis.riskLevel,
                            type: analysis.riskLevel == 'High'
                                ? AppStatusType.cancelled
                                : (analysis.riskLevel == 'Medium'
                                    ? AppStatusType.pending
                                    : AppStatusType.success),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),

                    // Summary Section
                    _buildSectionHeader(context.tr('summary'), isDark),
                    const SizedBox(height: 8),
                    AppCard(
                      child: Text(
                        analysis.summary,
                        style: AppTextStyles.bodyMedium(
                          color: isDark ? AppColors.white : AppColors.primaryNavy,
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),

                    // Key Points Section
                    _buildSectionHeader(context.tr('key_points'), isDark),
                    const SizedBox(height: 8),
                    AppCard(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: analysis.keyPoints
                            .map(
                              (point) => Padding(
                                padding: const EdgeInsets.symmetric(vertical: 4.0),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text('• ', style: TextStyle(fontWeight: FontWeight.bold)),
                                    Expanded(
                                      child: Text(
                                        point,
                                        style: AppTextStyles.bodyMedium(
                                          color: isDark ? AppColors.white : AppColors.primaryNavy,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            )
                            .toList(),
                      ),
                    ),
                    const SizedBox(height: 20),

                    // Potential Risks Section
                    _buildSectionHeader(context.tr('potential_risks'), isDark),
                    const SizedBox(height: 8),
                    AppCard(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: analysis.potentialRisks
                            .map(
                              (risk) => Padding(
                                padding: const EdgeInsets.symmetric(vertical: 4.0),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Icon(
                                      Icons.warning_amber_rounded,
                                      size: 18,
                                      color: AppColors.alertRed,
                                    ),
                                    const SizedBox(width: 8),
                                    Expanded(
                                      child: Text(
                                        risk,
                                        style: AppTextStyles.bodyMedium(
                                          color: isDark ? AppColors.white : AppColors.primaryNavy,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            )
                            .toList(),
                      ),
                    ),
                    const SizedBox(height: 20),

                    // Legal Suggestions Section
                    _buildSectionHeader(context.tr('legal_suggestions'), isDark),
                    const SizedBox(height: 8),
                    AppCard(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: analysis.suggestions
                            .map(
                              (sug) => Padding(
                                padding: const EdgeInsets.symmetric(vertical: 4.0),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Icon(
                                      Icons.check_circle_outline_rounded,
                                      size: 18,
                                      color: AppColors.successGreen,
                                    ),
                                    const SizedBox(width: 8),
                                    Expanded(
                                      child: Text(
                                        sug,
                                        style: AppTextStyles.bodyMedium(
                                          color: isDark ? AppColors.white : AppColors.primaryNavy,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            )
                            .toList(),
                      ),
                    ),
                    const SizedBox(height: 24),
                  ],
                ),
              );
            }
            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }

  Widget _buildSectionHeader(String title, bool isDark) {
    return Text(
      title,
      style: AppTextStyles.headingSmall(
        color: isDark ? AppColors.white : AppColors.primaryNavy,
      ),
    );
  }
}
