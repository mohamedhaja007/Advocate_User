import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/widgets/app_header.dart';
import '../../../../core/widgets/app_loader.dart';
import '../../../../core/widgets/app_error_view.dart';
import '../../../../core/widgets/app_empty_view.dart';
import '../../../../core/localization/app_localizations.dart';
import '../cubit/lawyer_cubit.dart';
import '../widgets/lawyer_card_widget.dart';

class SavedLawyersScreen extends StatefulWidget {
  const SavedLawyersScreen({super.key});

  @override
  State<SavedLawyersScreen> createState() => _SavedLawyersScreenState();
}

class _SavedLawyersScreenState extends State<SavedLawyersScreen> {
  @override
  void initState() {
    super.initState();
    context.read<LawyerCubit>().loadSavedLawyers();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppHeader(
        title: context.tr('saved_lawyers'),
        onBackPressed: () => context.pop(),
      ),
      body: SafeArea(
        child: BlocBuilder<LawyerCubit, LawyerState>(
          builder: (context, state) {
            if (state is LawyerLoading) {
              return const AppLoader(message: 'Loading saved lawyers...');
            } else if (state is LawyerError) {
              return AppErrorView(
                message: state.message,
                onRetry: () => context.read<LawyerCubit>().loadSavedLawyers(),
              );
            } else if (state is LawyersLoaded) {
              if (state.lawyers.isEmpty) {
                return const AppEmptyView(
                  title: 'No Saved Lawyers',
                  message: 'Bookmark advocates to access them quickly.',
                  icon: Icons.bookmark_border_rounded,
                );
              }
              return ListView.separated(
                padding: const EdgeInsets.all(16),
                itemCount: state.lawyers.length,
                separatorBuilder: (context, index) => const SizedBox(height: 16),
                itemBuilder: (context, index) {
                  final lawyer = state.lawyers[index];
                  return LawyerCardWidget(
                    lawyer: lawyer,
                    onTap: () =>
                        context.push('/lawyer-profile', extra: lawyer.id),
                    onBookVisit: () =>
                        context.push('/consultation-type', extra: lawyer),
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
