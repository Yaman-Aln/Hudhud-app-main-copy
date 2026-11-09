// Commented out for future use

/*
import 'package:tflite_flutter/tflite_flutter.dart';
import 'dart:typed_data';
import 'package:flutter/services.dart' show rootBundle;
import 'package:quran/quran.dart' as quran;

class ModelLoader {
  Interpreter? interpreter;

  Future<void> loadModel() async {
    try {
      final ByteData data = await rootBundle.load('assets/model/model.tflite');
      final buffer = data.buffer;

      interpreter = await Interpreter.fromBuffer(buffer.asUint8List());
      print('Model loaded successfully from buffer.');
    } catch (e) {
      print('Error loading model from buffer: $e');
    }
  }

  void close() {
    interpreter?.close();
    interpreter = null;
  }
}
*/
