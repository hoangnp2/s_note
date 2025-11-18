import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:s_note/features/presentation/cubit/language_cubit/language_cubit.dart';
import 'package:s_note/l10n/app_localizations.dart';

class ItemLanguage extends StatelessWidget {
  final String languageCode;
  const ItemLanguage({super.key, required this.languageCode});

  @override
  Widget build(BuildContext context) {
    final isSelected =
        context.watch<LanguageCubit>().state.locale.languageCode == languageCode;
    return ListTile(
      title: Text(
        languageCode == 'en'
            ? AppLocalizations.of(context)!.english
            : AppLocalizations.of(context)!.vietnamese,
      ),
      leading: Image.asset(
        languageCode == 'en'
            ? 'assets/image/en_flag.png'
            : 'assets/image/vi_flag.png',
        width: 24,
        height: 24,
      ),
      trailing: isSelected ? const Icon(Icons.check) : null,
      onTap: () {
        context.read<LanguageCubit>().changeLanguage(languageCode);
        Navigator.pop(context);
      },
    );
  }
}