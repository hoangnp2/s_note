import 'package:flutter/material.dart';
import 'package:s_note/core/core.dart';
import 'package:s_note/l10n/app_localizations.dart';

class CommonEmptyNotes extends StatelessWidget {
  const CommonEmptyNotes(this.drawerViewNote) : super(key: null);

  final DrawerSectionView drawerViewNote;

  @override
  Widget build(BuildContext context) {
    return _switchEmptySection(context, drawerViewNote);
  }

  _switchEmptySection(BuildContext context, DrawerSectionView drawerViewNote) {
    switch (drawerViewNote) {
      case DrawerSectionView.home:
        return CommonFixScrolling(
          onRefresh: () => AppFunction.onRefresh(context),
          child: _emptySection(
            AppIcons.emptyNote,
            AppLocalizations.of(context)!.noteYouAddAppearHere,
          ),
        );
      case DrawerSectionView.archive:
        return _emptySection(
          AppIcons.emptyArchivesNote,
          AppLocalizations.of(context)!.yourArchivedNotesAppearHere,
        );
      case DrawerSectionView.trash:
        return _emptySection(
          AppIcons.emptyTrashNote,
          AppLocalizations.of(context)!.noNotesInRecycleBin,
        );
    }
  }

  _emptySection(Icon appIcons, String errorMsg) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [appIcons, const SizedBox(height: 5.0), Text(errorMsg)],
      ),
    );
  }
}
