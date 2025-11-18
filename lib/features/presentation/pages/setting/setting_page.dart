import 'package:flutter/material.dart';
import 'package:s_note/features/presentation/pages/setting/widgets/language_item_tile.dart';

import 'widgets/widgets.dart';

import 'package:s_note/l10n/app_localizations.dart';

class SettingPage extends StatelessWidget {
  const SettingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(AppLocalizations.of(context)!.setting)),
      body: Sections(
        sections: [
          TilesSection(title: AppLocalizations.of(context)!.displayOption, tiles: const [ThemesItemTile(), LanguageItemTile()]),
        ],
      ),
    );
  }
}
