import 'package:dartz/dartz.dart';
import 'package:s_note/core/util/errors/failure.dart';

import '../entities/speech_to_text.dart';

/// Repository interface for Speech to Text functionality
abstract class SpeechToTextRepository {
  /// Initialize speech to text service
  Future<Either<Failure, bool>> initialize();

  /// Check microphone access permission
  Future<Either<Failure, bool>> checkPermission();


  /// Start listening to speech
  Future<Either<Failure, Stream<SpeechToTextResult>>> startListening({
    required SpeechToTextConfig config,
  });

  /// Stop listening to speech
  Future<Either<Failure, Unit>> stopListening();

  /// Cancel listening to speech
  Future<Either<Failure, Unit>> cancelListening();

  /// Check current status of speech service
  Future<Either<Failure, SpeechToTextResult>> getCurrentStatus();

  /// Get list of supported languages
  Future<Either<Failure, List<String>>> getSupportedLocales();

  /// Check if speech service is available
  Future<Either<Failure, bool>> isAvailable();
}