import 'package:dartz/dartz.dart';

import '../../../core/util/util.dart';
import '../repositories/speech_to_text_repository.dart';

class GetSpeechToTextPermissionUsecase {
  final SpeechToTextRepository speechToTextRepository;

  GetSpeechToTextPermissionUsecase({
    required this.speechToTextRepository,
  });

  /// Check current microphone access permission
  Future<Either<Failure, bool>> checkPermission() async {
    return await speechToTextRepository.checkPermission();
  }


  /// Check and request permission if necessary
  Future<Either<Failure, bool>> ensurePermission() async {
    final checkResult = await speechToTextRepository.checkPermission();
    
    return checkResult.fold(
      (failure) => Left(failure),
      (hasPermission) async {
        if (hasPermission) {
          return const Right(true);
        } else {
          return Left(NoDataFailure());
        }
      },
    );
  }
}