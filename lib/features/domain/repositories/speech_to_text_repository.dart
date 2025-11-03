import 'package:dartz/dartz.dart';
import 'package:s_note/core/util/errors/failure.dart';

import '../entities/speech_to_text.dart';

/// Repository interface cho Speech to Text functionality
abstract class SpeechToTextRepository {
  /// Khởi tạo speech to text service
  Future<Either<Failure, bool>> initialize();

  /// Kiểm tra quyền truy cập microphone
  Future<Either<Failure, bool>> checkPermission();

  /// Yêu cầu quyền truy cập microphone
  Future<Either<Failure, bool>> requestPermission();

  /// Bắt đầu lắng nghe giọng nói
  Future<Either<Failure, Stream<SpeechToTextResult>>> startListening({
    required SpeechToTextConfig config,
  });

  /// Dừng lắng nghe giọng nói
  Future<Either<Failure, Unit>> stopListening();

  /// Hủy lắng nghe giọng nói
  Future<Either<Failure, Unit>> cancelListening();

  /// Kiểm tra trạng thái hiện tại của speech service
  Future<Either<Failure, SpeechToTextResult>> getCurrentStatus();

  /// Lấy danh sách các ngôn ngữ được hỗ trợ
  Future<Either<Failure, List<String>>> getSupportedLocales();

  /// Kiểm tra xem speech service có khả dụng không
  Future<Either<Failure, bool>> isAvailable();
}