import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:s_note/features/presentation/cubit/language_cubit/language_cubit.dart';
import 'package:s_note/l10n/app_localizations.dart';

import 'item_language.dart';

class LanguageItemTile extends StatelessWidget {
  const LanguageItemTile({super.key});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(AppLocalizations.of(context)!.language),
      trailing: Text(
        context.watch<LanguageCubit>().state.locale.languageCode == 'en'
            ? AppLocalizations.of(context)!.english
            : AppLocalizations.of(context)!.vietnamese,
      ),
      onTap: () => _showLanguagesDialog(context),
    );
  }

  Future<void> _showLanguagesDialog(BuildContext context) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          contentPadding: const EdgeInsets.symmetric(vertical: 20),
          title: Text(AppLocalizations.of(context)!.language),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: const [
              ItemLanguage(languageCode: 'en'),
              ItemLanguage(languageCode: 'vi'),
            ],
          ),
        );
      },
    );
  }
}