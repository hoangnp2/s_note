import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:s_note/features/presentation/blocs/blocs.dart';

import '../../../../../core/core.dart';
import 'widgets.dart';

import 'package:s_note/l10n/app_localizations.dart';

class ThemesItemTile extends StatelessWidget {
  const ThemesItemTile({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeCubit, ThemeState>(
      builder: (context, state) {
        final currentTheme = (state as LoadedTheme).themeMode;
        final selectedTheme = AppThemes.values.firstWhere(
          (appTheme) => appTheme.mode == currentTheme,
        );
        return ListTile(
          title: Text(AppLocalizations.of(context)!.theme),
          trailing: Text(
            selectedTheme.title,
            style: context.textTheme.bodyLarge,
          ),
          leading: AppIcons.themes,
          onTap: () => _showThemesDialog(context),
        );
      },
    );
  }

  Future<void> _showThemesDialog(BuildContext context) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          contentPadding: const EdgeInsets.symmetric(vertical: 20),
          title: Text(AppLocalizations.of(context)!.chooseTheme),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: List.generate(
              AppThemes.values.length,
              (itemThemeIndex) => ItemTheme(indexTheme: itemThemeIndex),
            ),
          ),
        );
      },
    );
  }
}
