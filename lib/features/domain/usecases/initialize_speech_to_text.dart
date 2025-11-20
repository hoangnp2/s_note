import 'package:dartz/dartz.dart';

import '../../../core/util/util.dart';
import '../repositories/speech_to_text_repository.dart';

class InitializeSpeechToTextUsecase {
  final SpeechToTextRepository speechToTextRepository;

  InitializeSpeechToTextUsecase({
    required this.speechToTextRepository,
  });

  /// Initialize speech to text service
  Future<Either<Failure, bool>> call() async {
    return await speechToTextRepository.initialize();
  }

  /// Check if speech service is available
  Future<Either<Failure, bool>> isAvailable() async {
    return await speechToTextRepository.isAvailable();
  }

  /// Get list of supported languages
  Future<Either<Failure, List<String>>> getSupportedLocales() async {
    return await speechToTextRepository.getSupportedLocales();
  }

  /// Full initialization (check availability + initialize)
  Future<Either<Failure, bool>> initializeComplete() async {
    // Check availability first
    final availableResult = await speechToTextRepository.isAvailable();
    
    return availableResult.fold(
      (failure) => Left(failure),
      (isAvailable) async {
        if (!isAvailable) {
          return Left(SpeechToTextFailure('Speech to text service is not available'));
        }
        
        // If available, proceed with initialization
        return await speechToTextRepository.initialize();
      },
    );
  }
}

/// Custom failure class cho Speech to Text
class SpeechToTextFailure extends Failure {
  SpeechToTextFailure(String message) : super();
  
  @override
  List<Object?> get props => [];
}