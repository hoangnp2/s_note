import 'package:dartz/dartz.dart';

import '../../../core/util/util.dart';
import '../repositories/speech_to_text_repository.dart';

class GetSpeechToTextPermissionUsecase {
  final SpeechToTextRepository speechToTextRepository;

  GetSpeechToTextPermissionUsecase({
    required this.speechToTextRepository,
  });

  /// Kiểm tra quyền truy cập microphone hiện tại
  Future<Either<Failure, bool>> checkPermission() async {
    return await speechToTextRepository.checkPermission();
  }

  /// Yêu cầu quyền truy cập microphone
  Future<Either<Failure, bool>> requestPermission() async {
    return await speechToTextRepository.requestPermission();
  }

  /// Kiểm tra và yêu cầu quyền nếu cần thiết
  Future<Either<Failure, bool>> ensurePermission() async {
    final checkResult = await speechToTextRepository.checkPermission();
    
    return checkResult.fold(
      (failure) => Left(failure),
      (hasPermission) async {
        if (hasPermission) {
          return const Right(true);
        } else {
          return await speechToTextRepository.requestPermission();
        }
      },
    );
  }
}