import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:s_note/l10n/app_localizations.dart';

import '../../../../core/core.dart';
import '../../../domain/entities/note.dart';
import '../../blocs/blocs.dart';
import 'widget/widgets.dart';

class NotePage extends StatefulWidget {
  const NotePage({
    super.key,
    required this.note,
  });

  final Note note;

  @override
  State<NotePage> createState() => _NotePageState();
}

class _NotePageState extends State<NotePage> {
  final _titleController = TextEditingController();
  final _contentController = TextEditingController();
  final _undoController = UndoHistoryController();
  bool _isReminderPanelVisible = true;

  Color get noteColor {
    final noteBloc = context.read<NoteBloc>();
    return ColorNote.getColor(context, noteBloc.currentColor);
  }

  Note get originNote {
    return Note(
      id: widget.note.id,
      title: widget.note.title,
      content: widget.note.content,
      modifiedTime: widget.note.modifiedTime,
      colorIndex: widget.note.colorIndex,
      stateNote: widget.note.stateNote,
    );
  }

  Note get currentNote {
    final noteBloc = context.read<NoteBloc>();
    final noteStatusBloc = context.read<StatusIconsCubit>();
    //==>
    final StatusNote currentStatusNote =
        noteStatusBloc.state is ToggleIconsStatusState
            ? (noteStatusBloc.state as ToggleIconsStatusState).currentNoteStatus
            : StatusNote.trash;
    //==>
    return Note(
      id: widget.note.id,
      title: _titleController.text,
      content: _contentController.text,
      modifiedTime: widget.note.modifiedTime,
      colorIndex: noteBloc.currentColor,
      stateNote: currentStatusNote,
    );
  }

  @override
  void initState() {
    _loadNoteFields();
    super.initState();
  }

  void _loadNoteFields() {
    _titleController.text = widget.note.title;
    _contentController.text = widget.note.content;
  }

  @override
  void dispose() {
    _titleController.dispose();
    _contentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, _) {
        if (didPop) return;
        _onBack();
      },
      child: BlocConsumer<NoteBloc, NoteState>(
        listener: (context, state) => _displaylistener(context, state),
        builder: (context, state) {
          return Scaffold(
            backgroundColor: noteColor,
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerFloat,
            floatingActionButton: FloatingActionButton(
              onPressed: () {},
              child: const Icon(Icons.mic),
            ),
            bottomNavigationBar: CustomBottomBar(currentNote, _undoController),
            appBar: AppBarNote(press: _onBack),
            body: _buildBody(),
          );
        },
      ),
    );
  }

  Widget _buildBody() {
    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          children: [
            _buildReminderPanel(),
            TextFieldsForm(
              controllerTitle: _titleController,
              controllerContent: _contentController,
              undoController: _undoController,
              autofocus: false,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildReminderPanel() {
    return Visibility(
      visible: _isReminderPanelVisible,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
        child: Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.grey.withAlpha(25),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            children: [
              const Icon(
                Icons.notifications_none,
                size: 20,
              ),
              const SizedBox(width: 12),
              Column(
                children: [
                  Text(AppLocalizations.of(context)!.setRemider,
                  style: TextStyle(fontSize: 18),),
                  const Text(
                    'Today, 8:00 PM',
                    style: TextStyle(fontSize: 14),
                  ),
                ],
              ),
              const Spacer(),
              GestureDetector(
                onTap: () {
                  setState(() {
                    _isReminderPanelVisible = false;
                  });
                },
                child: const Icon(
                  Icons.close,
                  size: 20,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _onBack() {
    context.read<NoteBloc>().add(PopNoteAction(currentNote: currentNote,originNote:  originNote,l10n: AppLocalizations.of(context)!));
  }

  void _displaylistener(BuildContext context, NoteState state) {
    if (state is GoPopNoteState) context.pop();
  }
}
