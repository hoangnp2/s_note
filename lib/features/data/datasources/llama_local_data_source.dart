import 'dart:io';
import 'package:flutter/services.dart';
import 'package:llama_cpp_dart/llama_cpp_dart.dart';
import 'package:path_provider/path_provider.dart';

class LlamaLocalDataSource {
  LlamaProcessor? _processor;
  ContextParams? _context;
  bool _isModelLoaded = false;

  static const String _modelAssetPath = 'assets/models/my_model.gguf';
  static const String _modelFileName = 'my_model.gguf';

  Future<void> init() async {
    if (_isModelLoaded) return;

    try {
      final directory = await getApplicationDocumentsDirectory();
      final modelFile = File('${directory.path}/$_modelFileName');

      // Check if model file already exists to avoid copying every time
      if (!await modelFile.exists()) {
        print('Copying model from assets...');
        final ByteData modelData = await rootBundle.load(_modelAssetPath);
        final buffer = modelData.buffer;
        await modelFile.writeAsBytes(
          buffer.asUint8List(modelData.offsetInBytes, modelData.lengthInBytes),
        );
        print('Model copied to: ${modelFile.path}');
      } else {
        print('Model found at: ${modelFile.path}');
      }

      // Initialize the processor
      _processor = LlamaProcessor(modelFile.path);

      // Create context with parameters
      // You might want to make these configurable
      _context = _processor!.createContext(
        ContextParams(
          nCtx: 2048,
          nBatch: 512,
        ),
      );

      _isModelLoaded = true;
      print('Llama initialized successfully');
    } catch (e) {
      print('Error initializing Llama: $e');
      _isModelLoaded = false;
      // Re-throw or handle as needed
      throw Exception('Failed to initialize Llama model: $e');
    }
  }

  Stream<String> generateResponse(String prompt) async* {
    if (!_isModelLoaded || _context == null) {
      try {
        await init();
      } catch (e) {
        yield "Error: Failed to initialize AI Model.";
        return;
      }
    }

    // Format prompt (Simple format, adjust based on your specific model requirement e.g. ChatML, Alpaca)
    // This is a generic structure.
    final formattedPrompt = 'User: $prompt\nAssistant:';

    try {
      final stream = _context!.completionStream(
        formattedPrompt,
        nPredict: 512, // Max tokens to predict
        stop: ['User:', 'Assistant:'], // Stop sequences
      );

      await for (final token in stream) {
        yield token;
      }
    } catch (e) {
      yield "Error generating response: $e";
    }
  }

  void dispose() {
    _context?.dispose();
    _processor?.unloadModel();
    _isModelLoaded = false;
    print('Llama disposed');
  }
}
