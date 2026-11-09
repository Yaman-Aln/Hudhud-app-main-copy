// Commented out for future use

/*
import 'dart:typed_data';
import 'package:tflite_flutter/tflite_flutter.dart';
import 'model_loader.dart';
import 'package:quran/quran.dart' as quran;

class SpeechRecognitionService {
  ModelLoader _modelLoader = ModelLoader();
  Interpreter? _interpreter;

  Future<void> loadModel() async {
    await _modelLoader.loadModel();
    _interpreter = _modelLoader.interpreter;

    if (_interpreter != null) {
      print('Model loaded successfully via ModelLoader');
    } else {
      print('Error: Failed to load model via ModelLoader');
    }
  }

  String runModel(Uint8List audioData) {
    if (_interpreter == null) {
      print('Model is not loaded. Please load the model first.');
      return 'Error: Model not loaded';
    }

    try {
      var input = [audioData];
      var output = List.filled(1, 0).reshape([1]);

      _interpreter?.run(input, output);

      var result = output[0].toString();
      return result;
    } catch (e) {
      print('Error running model: $e');
      return 'Error: Failed to run model';
    }
  }

  void close() {
    _interpreter?.close();
    _interpreter = null;
  }
}
*/
