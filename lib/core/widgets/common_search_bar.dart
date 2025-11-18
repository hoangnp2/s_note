import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:s_note/l10n/app_localizations.dart';
import '../../features/presentation/blocs/blocs.dart';
import '../core.dart';

class CommonSearchBar extends StatelessWidget {
  const CommonSearchBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final String hintText = AppLocalizations.of(context)!.searchYourNotes;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: SizedBox(
        width: double.infinity,
        child: Material(
          borderRadius: BorderRadius.circular(25),
          child: InkWell(
            borderRadius: BorderRadius.circular(25),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    IconButton(
                      icon: AppIcons.menu,
                      onPressed: () => _openDrawer(context),
                    ),
                    Text(hintText, style: context.textTheme.bodyLarge),
                  ],
                ),
                const Row(
                  children: [IconStatusGridNote(), IconProfile()],
                ),
              ],
            ),
            onTap: () => _showSearch(context),
          ),
        ),
      ),
    );
  }

  void _openDrawer(BuildContext context) {
    context.read<NoteBloc>().appScaffoldState.currentState!.openDrawer();
  }

  Future _showSearch(BuildContext context) =>
      showSearch(context: context, delegate: NotesSearching());
}
