import 'package:flutter/material.dart';
import 'package:s_note/l10n/app_localizations.dart';

class AppBarTrash extends StatelessWidget implements PreferredSizeWidget {
  const AppBarTrash({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(AppLocalizations.of(context)!.trash),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
