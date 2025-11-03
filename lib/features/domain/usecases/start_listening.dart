import 'package:dartz/dartz.dart';

import '../../../core/util/util.dart';
import '../entities/speech_to_text.dart';
import '../repositories/speech_to_text_repository.dart';

class StartListeningUsecase {
  final SpeechToTextRepository speechToTextRepository;

  StartListeningUsecase({
    required this.speechToTextRepository,
  });

  Future<Either<Failure, Stream<SpeechToTextResult>>> call({
    SpeechToTextConfig? config,
  }) async {
    // Sử dụng config mặc định nếu không được cung cấp
    final speechConfig = config ?? const SpeechToTextConfig.defaultVi();
    
    return await speechToTextRepository.startListening(config: speechConfig);
  }
}