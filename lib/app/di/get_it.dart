import 'package:get_it/get_it.dart';

import 'package:shared_preferences/shared_preferences.dart';

import '../../features/data/datasources/local/hive/note_local_data_source_with_hive_impl.dart';
import '../../features/data/datasources/local/note_local_data_source.dart';
import '../../features/data/repositories/repositories_impl.dart';
import '../../features/domain/repositories/repositories.dart';
import '../../features/domain/usecases/add_note.dart';
import '../../features/domain/usecases/detele_note.dart';
import '../../features/domain/usecases/get_note_by_id.dart';
import '../../features/domain/usecases/get_notes.dart';
import '../../features/domain/usecases/update_note.dart';
import '../../features/presentation/blocs/blocs.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import '../../features/data/datasources/notification_local_data_source.dart';
import '../../features/data/repositories/notification_repository_impl.dart';
import '../../features/domain/repositories/notification_repository.dart';
import '../../features/domain/usecases/schedule_notification_use_case.dart';
import '../../features/data/datasources/llama_local_data_source.dart';
import '../../features/data/repositories/ai_repository_impl.dart';
import '../../features/domain/repositories/ai_repository.dart';
import '../../features/domain/usecases/generate_ai_response_use_case.dart';

final gI = GetIt.I;

Future<void> init() async {
  //=> BloC //
  gI.registerFactory(
    () => NoteBloc(
      getNotes: gI(),
      getNoteById: gI(),
      addNote: gI(),
      updateNote: gI(),
      deleteNote: gI(),
    ),
  );

  gI.registerFactory(() => StatusIconsCubit());
  gI.registerFactory(() => StatusGridCubit());
  gI.registerFactory(() => ProfileCubit(sharedPreferences: gI()));
  gI.registerFactory(() => ThemeCubit(sharedPreferences: gI()));
  gI.registerFactory(() => SearchCubit(getNotes: gI()));

  //=> Usecases
  gI.registerLazySingleton(() => GetNotesUsecase(noteRepositories: gI()));
  gI.registerLazySingleton(() => GetNoteByIdUsecase(noteRepositories: gI()));
  gI.registerLazySingleton(() => AddNoteUsecase(noteRepositories: gI()));
  gI.registerLazySingleton(() => UpdateNoteUsecase(noteRepositories: gI()));
  gI.registerLazySingleton(() => DeleteNoteUsecase(noteRepositories: gI()));
  gI.registerLazySingleton(() => ScheduleNotificationUseCase(gI()));
  gI.registerLazySingleton(() => GenerateAiResponseUseCase(gI()));

  //=> Repository
  gI.registerLazySingleton<NoteRepositories>(
    () => NoteRepositoriesImpl(noteLocalDataSourse: gI()),
  );
 
  gI.registerLazySingleton<AiRepository>(
    () => AiRepositoryImpl(gI()),
  );

  //=> Datasourse
  gI.registerLazySingleton<NoteLocalDataSourse>(
    () => NoteLocalDataSourceWithHiveImpl(),
  );

  gI.registerLazySingleton<LlamaLocalDataSource>(
    () => LlamaLocalDataSource(),
  );

  await gI<NoteLocalDataSourse>().initDb();
  await gI<NotificationLocalDataSource>().init();

  //! Core !//
  //! External!//
  final sharedPreferences = await SharedPreferences.getInstance();
  gI.registerLazySingleton(() => sharedPreferences);
  gI.registerLazySingleton(() => FlutterLocalNotificationsPlugin());
  //
}
