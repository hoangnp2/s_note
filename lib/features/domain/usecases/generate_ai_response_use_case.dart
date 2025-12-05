import '../repositories/ai_repository.dart';

class GenerateAiResponseUseCase {
  final AiRepository repository;

  GenerateAiResponseUseCase(this.repository);

  Stream<String> call(String prompt) {
    return repository.generateResponse(prompt);
  }
}
