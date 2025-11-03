import 'package:dartz/dartz.dart';

import '../../../core/util/util.dart';
import '../repositories/speech_to_text_repository.dart';

class CancelListeningUsecase {
  final SpeechToTextRepository speechToTextRepository;

  CancelListeningUsecase({
    required this.speechToTextRepository,
  });

  Future<Either<Failure, Unit>> call() async {
    return await speechToTextRepository.cancelListening();
  }
}