import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:s_note/core/util/errors/failure.dart';
import 'package:s_note/features/domain/entities/speech_to_text.dart';
import 'package:s_note/features/domain/repositories/speech_to_text_repository.dart';
import 'package:s_note/features/domain/usecases/initialize_speech_to_text.dart';
import 'package:speech_to_text/speech_to_text.dart';

class SpeechToTextRepositoriesImpl implements SpeechToTextRepository {
  final SpeechToText _speechToText = SpeechToText();

  @override
  Future<Either<Failure, Unit>> cancelListening() async {
    try {
      await _speechToText.cancel();
      return Right(unit);
    } catch (e) {
      return Left(SpeechToTextFailure('Failed to cancel listening: $e'));
    }
  }

  @override
  Future<Either<Failure, bool>> checkPermission() async {
    try {
      final hasPermission = await _speechToText.hasPermission;
      return Right(hasPermission);
    } catch (e) {
      return Left(SpeechToTextFailure('Failed to check permission: $e'));
    }
  }

  @override
  Future<Either<Failure, SpeechToTextResult>> getCurrentStatus() async {
    try {
      final isListening = _speechToText.isListening;
      final isInitialized = await _speechToText.isAvailable; // Check again to get status
      return Right(SpeechToTextResult(
        recognizedWords: '', // No current recognized words, may need to store state
        isListening: isListening,
        hasError: false,
        errorMessage: '',
        confidence: 0.0,
        isInitialized: isInitialized,
        hasPermission: await _speechToText.hasPermission,
      ));
    } catch (e) {
      return Left(SpeechToTextFailure('Failed to get current status: $e'));
    }
  }

  @override
  Future<Either<Failure, List<String>>> getSupportedLocales() async {
    try {
      final locales = await _speechToText.locales();
      return Right(locales.map((locale) => locale.localeId).toList());
    } catch (e) {
      return Left(SpeechToTextFailure('Failed to get supported locales: $e'));
    }
  }

  @override
  Future<Either<Failure, bool>> initialize() async {
    try {
      final isInitialized = await _speechToText.initialize();
      return Right(isInitialized);
    } catch (e) {
      return Left(SpeechToTextFailure('Failed to initialize speech to text: $e'));
    }
  }

  @override
  Future<Either<Failure, bool>> isAvailable() async {
    try {
      return Right(await _speechToText.isAvailable);
    } catch (e) {
      return Left(SpeechToTextFailure('Failed to check availability: $e'));
    }
  }

  

  @override
  Future<Either<Failure, Stream<SpeechToTextResult>>> startListening({
    required SpeechToTextConfig config,
  }) async {
    try {
      final resultStream = StreamController<SpeechToTextResult>();

      await _speechToText.listen(
        onResult: (result) {
          resultStream.add(SpeechToTextResult(
            recognizedWords: result.recognizedWords,
            isListening: true,
            hasError: false,
            errorMessage: '',
            confidence: result.confidence,
            isInitialized: true,
            hasPermission: true,
          ));
        },
        localeId: config.localeId,
        partialResults: config.partialResults,
        listenFor: config.listenTimeout,
        pauseFor: config.pauseTimeout,
      );

      return Right(resultStream.stream);
    } catch (e) {
      return Left(SpeechToTextFailure('Failed to start listening: $e'));
    }
  }

  @override
  Future<Either<Failure, Unit>> stopListening() async {
    try {
      await _speechToText.stop();
      return Right(unit);
    } catch (e) {
      return Left(SpeechToTextFailure('Failed to stop listening: $e'));
    }
  }
}