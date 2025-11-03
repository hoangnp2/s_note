import 'package:equatable/equatable.dart';

/// Entity đại diện cho trạng thái và kết quả của Speech to Text
class SpeechToTextResult extends Equatable {
  final String recognizedWords;
  final bool isListening;
  final bool hasError;
  final String errorMessage;
  final double confidence;
  final bool isInitialized;
  final bool hasPermission;

  const SpeechToTextResult({
    required this.recognizedWords,
    required this.isListening,
    required this.hasError,
    required this.errorMessage,
    required this.confidence,
    required this.isInitialized,
    required this.hasPermission,
  });

  /// Constructor cho trạng thái ban đầu
  const SpeechToTextResult.initial()
      : recognizedWords = '',
        isListening = false,
        hasError = false,
        errorMessage = '',
        confidence = 0.0,
        isInitialized = false,
        hasPermission = false;

  /// Constructor cho trạng thái lỗi
  const SpeechToTextResult.error(String error)
      : recognizedWords = '',
        isListening = false,
        hasError = true,
        errorMessage = error,
        confidence = 0.0,
        isInitialized = false,
        hasPermission = false;

  /// Copy with method để tạo instance mới với một số thuộc tính thay đổi
  SpeechToTextResult copyWith({
    String? recognizedWords,
    bool? isListening,
    bool? hasError,
    String? errorMessage,
    double? confidence,
    bool? isInitialized,
    bool? hasPermission,
  }) {
    return SpeechToTextResult(
      recognizedWords: recognizedWords ?? this.recognizedWords,
      isListening: isListening ?? this.isListening,
      hasError: hasError ?? this.hasError,
      errorMessage: errorMessage ?? this.errorMessage,
      confidence: confidence ?? this.confidence,
      isInitialized: isInitialized ?? this.isInitialized,
      hasPermission: hasPermission ?? this.hasPermission,
    );
  }

  @override
  List<Object?> get props => [
        recognizedWords,
        isListening,
        hasError,
        errorMessage,
        confidence,
        isInitialized,
        hasPermission,
      ];
}

/// Entity đại diện cho cấu hình Speech to Text
class SpeechToTextConfig extends Equatable {
  final String localeId;
  final bool partialResults;
  final Duration listenTimeout;
  final Duration pauseTimeout;

  const SpeechToTextConfig({
    required this.localeId,
    required this.partialResults,
    required this.listenTimeout,
    required this.pauseTimeout,
  });

  /// Constructor mặc định với cấu hình tiếng Việt
  const SpeechToTextConfig.defaultVi()
      : localeId = 'vi_VN',
        partialResults = true,
        listenTimeout = const Duration(seconds: 30),
        pauseTimeout = const Duration(seconds: 3);

  /// Constructor mặc định với cấu hình tiếng Anh
  const SpeechToTextConfig.defaultEn()
      : localeId = 'en_US',
        partialResults = true,
        listenTimeout = const Duration(seconds: 30),
        pauseTimeout = const Duration(seconds: 3);

  @override
  List<Object?> get props => [
        localeId,
        partialResults,
        listenTimeout,
        pauseTimeout,
      ];
}