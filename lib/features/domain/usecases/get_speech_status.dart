import 'package:dartz/dartz.dart';

import '../../../core/util/util.dart';
import '../entities/speech_to_text.dart';
import '../repositories/speech_to_text_repository.dart';

class GetSpeechStatusUsecase {
  final SpeechToTextRepository speechToTextRepository;

  GetSpeechStatusUsecase({
    required this.speechToTextRepository,
  });

  Future<Either<Failure, SpeechToTextResult>> call() async {
    return await speechToTextRepository.getCurrentStatus();
  }
}