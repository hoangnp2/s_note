import 'package:dartz/dartz.dart';

import '../../../core/util/util.dart';
import '../repositories/speech_to_text_repository.dart';

class InitializeSpeechToTextUsecase {
  final SpeechToTextRepository speechToTextRepository;

  InitializeSpeechToTextUsecase({
    required this.speechToTextRepository,
  });

  /// Khởi tạo speech to text service
  Future<Either<Failure, bool>> call() async {
    return await speechToTextRepository.initialize();
  }

  /// Kiểm tra xem speech service có khả dụng không
  Future<Either<Failure, bool>> isAvailable() async {
    return await speechToTextRepository.isAvailable();
  }

  /// Lấy danh sách các ngôn ngữ được hỗ trợ
  Future<Either<Failure, List<String>>> getSupportedLocales() async {
    return await speechToTextRepository.getSupportedLocales();
  }

  /// Khởi tạo đầy đủ (kiểm tra khả dụng + khởi tạo)
  Future<Either<Failure, bool>> initializeComplete() async {
    // Kiểm tra khả dụng trước
    final availableResult = await speechToTextRepository.isAvailable();
    
    return availableResult.fold(
      (failure) => Left(failure),
      (isAvailable) async {
        if (!isAvailable) {
          return Left(SpeechToTextFailure('Speech to text service is not available'));
        }
        
        // Nếu khả dụng, tiến hành khởi tạo
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