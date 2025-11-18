import 'package:dartz/dartz.dart';
import 'package:logger/logger.dart';

import '../../../core/util/util.dart';
import '../../domain/entities/note.dart';
import '../../domain/repositories/repositories.dart';
import '../datasources/local/note_local_data_source.dart';
import '../model/note_model.dart';

class NoteRepositoriesImpl implements NoteRepositories {
  final NoteLocalDataSourse noteLocalDataSourse;
  final Logger logger = Logger();

  NoteRepositoriesImpl({
    required this.noteLocalDataSourse,
  });

  @override
  Future<Either<Failure, List<Note>>> getAllNotes() async {
    try {
      final response = await noteLocalDataSourse.getAllNote();
      logger.i('Get all notes successfully');
      for (var note in response) { logger.i(note.content); }
      return Right(response);
    } on NoDataException {
      return Left(NoDataFailure());
    }
  }

  @override
  Future<Either<Failure, Note>> getNoteById(String noteId) async {
    try {
      final response = await noteLocalDataSourse.getNoteById(noteId);
      logger.i('Get note by id successfully');
      return Right(response);
    } on NoDataException {
      return Left(NoDataFailure());
    }
  }

  @override
  Future<Either<Failure, Unit>> addNote(Note note) async {
    try {
      if (note.title.isEmpty && note.content.isEmpty) {
        return Left(EmpytInputFailure());
      } else {
        final NoteModel convertToNoteModel = NoteModel(
          id: note.id,
          title: note.title,
          content: note.content,
          colorIndex: note.colorIndex,
          modifiedTime: note.modifiedTime,
          stateNote: note.stateNote,
        );
        await noteLocalDataSourse.addNote(convertToNoteModel);
        logger.i('Add note successfully');
        return const Right(unit);
      }
    } on NoDataException {
      return Left(NoDataFailure());
    }
  }

  @override
  Future<Either<Failure, Unit>> updateNote(Note note) async {
    try {
      final NoteModel convertToNoteModel = NoteModel(
        id: note.id,
        title: note.title,
        content: note.content,
        colorIndex: note.colorIndex,
        modifiedTime: note.modifiedTime,
        stateNote: note.stateNote,
      );
      await noteLocalDataSourse.updateNote(convertToNoteModel);
      logger.i('Update note successfully');
      return const Right(unit);
    } on NoDataException {
      return Left(NoDataFailure());
    }
  }

  @override
  Future<Either<Failure, Unit>> deleteNote(String noteId) async {
    try {
      await noteLocalDataSourse.deleteNote(noteId);
      logger.i('Delete note successfully');
      return const Right(unit);
    } on NoDataException {
      return Left(NoDataFailure());
    }
  }

  // Future<Either<Failure, T>> executeAndHandleError<T>(
  //   Future<T> Function() function,
  // ) async {
  //   try {
  //     final result = await function();
  //     return Right(result);
  //   } on NoDataException {
  //     return Left(NoDataFailure());
  //   }
  // }
}
