import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:s_note/core/core.dart';
import 'package:s_note/features/presentation/blocs/blocs.dart';
import 'package:s_note/l10n/app_localizations.dart';

class NoteApp extends StatelessWidget {
  const NoteApp({super.key});

  @override
  Widget build(BuildContext context) {
    AppDevice.setStatusBart(context);
    return BlocBuilder<ThemeCubit, ThemeState>(
      builder: (context, state) {
        if (state is LoadedTheme) {
          return MaterialApp.router(
            debugShowCheckedModeBanner: false,
            title: 'Note App Version 2',
            theme: AppTheme.light,
            darkTheme: AppTheme.dark,
            themeMode: state.themeMode,
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            supportedLocales: AppLocalizations.supportedLocales,
            routeInformationParser: AppRouter.router.routeInformationParser,
            routerDelegate: AppRouter.router.routerDelegate,
            routeInformationProvider: AppRouter.router.routeInformationProvider,
          );
        }
        return const SizedBox.shrink();
      },
    );
  }
}
