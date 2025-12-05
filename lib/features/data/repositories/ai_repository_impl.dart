import '../../domain/repositories/ai_repository.dart';
import '../datasources/llama_local_data_source.dart';

class AiRepositoryImpl implements AiRepository {
  final LlamaLocalDataSource dataSource;

  AiRepositoryImpl(this.dataSource);

  @override
  Stream<String> generateResponse(String prompt) {
    return dataSource.generateResponse(prompt);
  }
}
