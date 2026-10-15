import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'core/di/service_locator.dart';
import 'core/theme/app_theme.dart';
import 'core/localization/app_localizations.dart';
import 'core/localization/locale_cubit.dart';
import 'core/localization/localization_config.dart';
import 'app/routes/app_router.dart';

import 'features/auth/presentation/cubit/auth_cubit.dart';
import 'features/home/presentation/cubit/home_cubit.dart';
import 'features/lawyers/presentation/cubit/lawyer_cubit.dart';
import 'features/bookings/presentation/cubit/booking_cubit.dart';
import 'features/ai_assistant/presentation/cubit/ai_assistant_cubit.dart';
import 'features/documents/presentation/cubit/document_cubit.dart';
import 'features/account/presentation/cubit/account_cubit.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initServiceLocator();
  runApp(const AvvocatUserApp());
}

class AvvocatUserApp extends StatelessWidget {
  const AvvocatUserApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<ThemeCubit>.value(value: sl<ThemeCubit>()),
        BlocProvider<LocaleCubit>.value(value: sl<LocaleCubit>()),
        BlocProvider<AuthCubit>(create: (_) => sl<AuthCubit>()),
        BlocProvider<HomeCubit>(create: (_) => sl<HomeCubit>()),
        BlocProvider<LawyerCubit>(create: (_) => sl<LawyerCubit>()),
        BlocProvider<BookingCubit>(create: (_) => sl<BookingCubit>()),
        BlocProvider<AiAssistantCubit>(create: (_) => sl<AiAssistantCubit>()),
        BlocProvider<DocumentCubit>(create: (_) => sl<DocumentCubit>()),
        BlocProvider<AccountCubit>(create: (_) => sl<AccountCubit>()),
      ],
      child: BlocBuilder<ThemeCubit, ThemeMode>(
        builder: (context, themeMode) {
          return BlocBuilder<LocaleCubit, Locale>(
            builder: (context, locale) {
              return MaterialApp.router(
                title: 'AvvocatAI',
                debugShowCheckedModeBanner: false,
                theme: AppTheme.light,
                darkTheme: AppTheme.dark,
                themeMode: themeMode,
                locale: locale,
                supportedLocales: LocalizationConfig.supportedLocales,
                localizationsDelegates: const [
                  AppLocalizations.delegate,
                  GlobalMaterialLocalizations.delegate,
                  GlobalWidgetsLocalizations.delegate,
                  GlobalCupertinoLocalizations.delegate,
                ],
                routerConfig: appRouter,
              );
            },
          );
        },
      ),
    );
  }
}
