import 'package:flutter_sound/flutter_sound.dart';
import 'package:permission_handler/permission_handler.dart';
import 'dart:io';
import 'package:quran/quran.dart' as quran;
import '../providers/ff_logging_service_provider.dart';

class AudioRecorder {
  final _flutterSound = FlutterSoundRecorder();

  Future<void> startRecording() async {
    // Request microphone permission
    var status = await Permission.microphone.request();
    if (status.isGranted) {
      // Open the audio recorder
      await _flutterSound.openRecorder();
      await _flutterSound.startRecorder(
        toFile: 'audio.wav',
        codec: Codec.pcm16WAV,
      );
    } else {
      throw RecordingPermissionException('Microphone permission not granted');
    }
  }

  Future<String?> stopRecording() async {
    // Stop the recorder and get the file path
    String? path = await _flutterSound.stopRecorder();
    await _flutterSound.closeRecorder();

    if (path != null) {
      // Debug statement to confirm the file path
      return path;  // Return the path to the original recording
    }
    return null;
  }
}
