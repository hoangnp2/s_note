import 'package:dartz/dartz.dart';

import '../../../core/util/util.dart';
import '../repositories/speech_to_text_repository.dart';

class StopListeningUsecase {
  final SpeechToTextRepository speechToTextRepository;

  StopListeningUsecase({
    required this.speechToTextRepository,
  });

  Future<Either<Failure, Unit>> call() async {
    return await speechToTextRepository.stopListening();
  }
}