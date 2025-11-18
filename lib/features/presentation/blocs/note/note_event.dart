part of 'note_bloc.dart';


sealed class NoteEvent extends Equatable {
  const NoteEvent();

  @override
  List<Object> get props => [];
}

final class EmptyInputs extends NoteEvent {
  final AppLocalizations l10n;

  const EmptyInputs(this.l10n);
}

final class LoadNotes extends NoteEvent {
  final DrawerSectionView drawerSectionView;

  const LoadNotes({
    this.drawerSectionView = DrawerSectionView.home,
  });

  @override
  List<Object> get props => [drawerSectionView];
}

final class RefreshNotes extends NoteEvent {
  final DrawerSectionView drawerSectionView;

  const RefreshNotes(
    this.drawerSectionView,
  );

  @override
  List<Object> get props => [drawerSectionView];
}

final class AddNote extends NoteEvent {
  final Note note;
  final AppLocalizations l10n;

  const AddNote(this.note, this.l10n);
  @override
  List<Object> get props => [note];
}

final class GetNoteById extends NoteEvent {
  final String noteId;

  const GetNoteById(
    this.noteId,
  );

  @override
  List<Object> get props => [noteId];
}

final class UpdateNote extends NoteEvent {
  final Note note;
  final AppLocalizations l10n;

  const UpdateNote(this.note, this.l10n);

  @override
  List<Object> get props => [note];
}

final class DeleteNote extends NoteEvent {
  final String noteId;
  final AppLocalizations l10n;

  const DeleteNote(this.noteId, this.l10n);
  @override
  List<Object> get props => [noteId];
}

final class ModifColorNote extends NoteEvent {
  final int colorIndex;

  const ModifColorNote(
    this.colorIndex,
  );
  @override
  List<Object> get props => [colorIndex];
}

final class MoveNote extends NoteEvent {
  final Note? note;
  final StatusNote newStatus;
  final AppLocalizations l10n;

  const MoveNote(
    this.note,
    this.newStatus,
    this.l10n,
  );

  @override
  List<Object> get props => [];
}

final class UndoMoveNote extends NoteEvent {}

final class PopNoteAction extends NoteEvent {
  final Note currentNote;
  final Note originNote;
  final AppLocalizations l10n;

const PopNoteAction({
    required this.currentNote,
    required this.originNote,
    required this.l10n,
  });

  @override
  List<Object> get props => [currentNote, originNote];
}














// class AvailableNote extends NoteEvent {
//   final Note note;

//   const AvailableNote(
//     this.note,
//   );

//   @override
//   List<Object> get props => [note];
// }

// class ReadOnlyNote extends NoteEvent {
//   final Note note;

//   const ReadOnlyNote(
//     this.note,
//   );

//   @override
//   List<Object> get props => [note];
// }
