import 'dart:async';
import 'dart:io';
import 'dart:math' as math; // for sqrt
import 'dart:typed_data';  // <-- IMPORTANT: needed for Uint8List
import 'package:flutter/material.dart'; // For showDialog
import 'package:flutter_sound/flutter_sound.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:path_provider/path_provider.dart';

import '../providers/ff_logging_service_provider.dart';
import '../services/whisper_local_api.dart';

// NEW: We'll need your generated localizations
import 'package:hudhud_quran_app_new/l10n/app_localizations.dart';

/// Manages microphone recording via flutter_sound
/// and sends data to your self-hosted Whisper for transcription.
///
/// All error popups are shown here, but we no longer pass [BuildContext]
/// around in methods. Instead, we use a global [navigatorKey] to retrieve
/// the current context for showDialog calls, so you won't get context errors.
class VoiceTranscriptionService extends ChangeNotifier {
  // -------------------------------------------------------------------------
  // Dependencies
  // -------------------------------------------------------------------------
  final LoggingService loggingService;
  final LocalWhisperApi localWhisperApi;

  /// A [GlobalKey] that gives us a reference to the Navigator,
  /// allowing showDialog without a direct BuildContext param.
  final GlobalKey<NavigatorState> navigatorKey;

  // -------------------------------------------------------------------------
  // Internal State
  // -------------------------------------------------------------------------
  bool _isRecording = false;
  String _partialTranscript = '';
  String _finalTranscript = '';
  String? _recordedFilePath;

  /// We'll use this timer to auto-stop after 15 seconds
  Timer? _autoStopTimer;

  // Our flutter_sound recorder
  final FlutterSoundRecorder _recorder = FlutterSoundRecorder();

  // -------------------------------------------------------------------------
  // Optional: chunk-based streaming fields
  // -------------------------------------------------------------------------
  StreamSubscription<Uint8List>? _recordingSubscription;
  final List<int> _audioBuffer = [];
  final _chunkController = StreamController<Uint8List>.broadcast();

  // -------------------------------------------------------------------------
  // Constructor
  // -------------------------------------------------------------------------
  VoiceTranscriptionService({
    required this.loggingService,
    required this.localWhisperApi,
    required this.navigatorKey,
  }) {
    _initRecorder();
  }

  bool get isRecording => _isRecording;
  String get partialTranscript => _partialTranscript;
  String get finalTranscript => _finalTranscript;

  // -------------------------------------------------------------------------
  // Initialization
  // -------------------------------------------------------------------------
  Future<void> _initRecorder() async {
    try {
      await _recorder.openRecorder();
      loggingService.logInfo('[VoiceTranscriptionService] Recorder opened');
    } catch (e, st) {
      loggingService.logError(
        '[VoiceTranscriptionService] Error opening recorder: $e\n$st',
      );
    }
  }

  // -------------------------------------------------------------------------
  // Utility: show an error popup with localized text
  // -------------------------------------------------------------------------
  Future<void> _showErrorDialog({
    required String title,
    required String message,
    required String semanticLabel,
  }) async {
    // 1) Attempt to find a valid BuildContext from the navigatorKey
    final ctx = navigatorKey.currentContext;
    if (ctx == null) {
      loggingService.logError(
        '[VoiceTranscriptionService] _showErrorDialog => no Navigator context available!',
      );
      return;
    }

    // 2) Grab localizations
    final loc = AppLocalizations.of(ctx)!;

    // 3) Show the dialog
    await showDialog<void>(
      context: ctx,
      builder: (dialogCtx) {
        return Semantics(
          label: semanticLabel,
          child: AlertDialog(
            semanticLabel: semanticLabel,
            title: Text(title, style: const TextStyle(color: Colors.black)),
            content: Text(message, style: const TextStyle(color: Colors.black)),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(dialogCtx).pop(),
                child: Text(
                  loc.okLabel,
                  style: const TextStyle(color: Colors.blue),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  // -------------------------------------------------------------------------
  // RMS-based Silence Check
  // -------------------------------------------------------------------------
  Future<bool> _isSilentWav(String path, {double threshold = 200.0}) async {
    final bytes = await File(path).readAsBytes();
    if (bytes.length <= 44) {
      // No audio data
      return true;
    }
    // Skip 44-byte WAV header
    final audioData = bytes.sublist(44);

    final sampleCount = audioData.length ~/ 2;
    double sumOfSquares = 0.0;

    for (int i = 0; i < audioData.length; i += 2) {
      int low = audioData[i] & 0xFF;
      int high = audioData[i + 1];
      int sample = (high << 8) | low;
      // sign convert
      if ((sample & 0x8000) != 0) {
        sample = -(0x10000 - sample);
      }
      sumOfSquares += sample * sample;
    }

    final rms = math.sqrt(sumOfSquares / sampleCount);
    return rms < threshold;
  }

  // -------------------------------------------------------------------------
  // Single-file Recording
  // -------------------------------------------------------------------------
  /// Starts recording to a local WAV file
  Future<void> startRecording() async {
    final ctx = navigatorKey.currentContext;
    if (ctx == null) {
      loggingService.logError('[VoiceTranscriptionService] startRecording => no context');
      return;
    }
    final loc = AppLocalizations.of(ctx)!;

    // Check microphone permission
    final status = await Permission.microphone.request();
    if (!status.isGranted) {
      loggingService.logError('[VoiceTranscriptionService] Mic permission denied');
      await _showErrorDialog(
        title: loc.voiceErrorMicDeniedTitle,
        message: loc.voiceErrorMicDeniedBody,
        semanticLabel: loc.voiceErrorMicDeniedSemanticLabel,
      );
      return;
    }

    if (_recorder.isRecording) {
      loggingService.logWarning('[VoiceTranscriptionService] Already recording!');
      return;
    }

    try {
      // Build a unique path in temp dir
      final tempDir = await getTemporaryDirectory();
      final filePath =
          '${tempDir.path}/voice_capture_${DateTime.now().millisecondsSinceEpoch}.wav';

      _partialTranscript = '';
      _finalTranscript = '';
      _recordedFilePath = filePath;

      await _recorder.startRecorder(
        toFile: filePath,
        codec: Codec.pcm16WAV,
      );
      _isRecording = true;
      loggingService.logInfo('[VoiceTranscriptionService] Recording started -> $filePath');

      // Cancel any existing timer, then set up a 15-second auto-stop
      _autoStopTimer?.cancel();
      _autoStopTimer = Timer(const Duration(seconds: 15), () async {
        if (_recorder.isRecording) {
          loggingService.logInfo('[VoiceTranscriptionService] Auto-stopping after 15s...');
          await stopRecording();
        }
      });
    } catch (e, st) {
      loggingService.logError(
        '[VoiceTranscriptionService] Error starting recorder: $e\n$st',
      );
      _isRecording = false;

      // Show localized popup
      await _showErrorDialog(
        title: loc.voiceErrorRecorderStartTitle,
        message: loc.voiceErrorRecorderStartBody,
        semanticLabel: loc.voiceErrorRecorderStartSemanticLabel,
      );
    }

    notifyListeners();
  }

  /// Stops the current recording, if any
  Future<void> stopRecording() async {
    final ctx = navigatorKey.currentContext;
    if (ctx == null) {
      loggingService.logError('[VoiceTranscriptionService] stopRecording => no context');
      return;
    }
    final loc = AppLocalizations.of(ctx)!;

    if (!_recorder.isRecording) {
      loggingService.logWarning('[VoiceTranscriptionService] Recorder not active');
      return;
    }

    // Cancel the auto-stop timer so it doesn't fire again
    _autoStopTimer?.cancel();
    _autoStopTimer = null;

    String? flutterSoundPath;
    try {
      flutterSoundPath = await _recorder.stopRecorder();
      _isRecording = false;
      loggingService.logInfo('[VoiceTranscriptionService] Recording stopped -> $flutterSoundPath');
    } catch (e, st) {
      loggingService.logError(
        '[VoiceTranscriptionService] Error stopping recorder: $e\n$st',
      );
      _isRecording = false;
      notifyListeners();

      // Show a popup
      await _showErrorDialog(
        title: loc.voiceErrorRecorderStopTitle,
        message: loc.voiceErrorRecorderStopBody,
        semanticLabel: loc.voiceErrorRecorderStopSemanticLabel,
      );
      return;
    }

    final finalPath = (flutterSoundPath == null || flutterSoundPath.isEmpty)
        ? _recordedFilePath
        : flutterSoundPath;

    if (finalPath == null || finalPath.isEmpty) {
      loggingService.logWarning('[VoiceTranscriptionService] No valid file path => skip transcribe');
      notifyListeners();
      return;
    }

    // -- 1) Check Silence
    try {
      final silent = await _isSilentWav(finalPath, threshold: 200.0);
      if (silent) {
        loggingService.logWarning('[VoiceTranscriptionService] File is near-silence => skip');
        _finalTranscript = '';
        _partialTranscript = '';
        notifyListeners();

        // Show popup for "No sound"
        await _showErrorDialog(
          title: loc.voiceErrorNoSoundTitle,
          message: loc.voiceErrorNoSoundBody,
          semanticLabel: loc.voiceErrorNoSoundSemanticLabel,
        );
        return;
      }
    } catch (e, st) {
      loggingService.logError('[VoiceTranscriptionService] Error checking silence: $e\n$st');
      // (Optional) show partial error if you want
    }

    // -- 2) Transcribe
    try {
      final fileBytes = await File(finalPath).readAsBytes();
      loggingService.logInfo('[VoiceTranscriptionService] Sending audio to Whisper...');
      final transcript = await localWhisperApi.transcribeAudio(
        audioBytes: fileBytes,
        fileName: 'recorded_audio.wav',
      );
      _finalTranscript = transcript;
      _partialTranscript = transcript;
      loggingService.logInfo('[VoiceTranscriptionService] Final transcript: $transcript');
    } catch (e, st) {
      loggingService.logError(
        '[VoiceTranscriptionService] Could not read/transcribe file: $e\n$st',
      );
      // Show "No internet" or "Server error" popup
      await _showErrorDialog(
        title: loc.voiceErrorTranscriptionTitle,
        message: loc.voiceErrorTranscriptionBody,
        semanticLabel: loc.voiceErrorTranscriptionSemanticLabel,
      );
    }

    notifyListeners();
  }

  // -------------------------------------------------------------------------
  // Optional transcribeRecordedFile
  // -------------------------------------------------------------------------
  /// Transcribes an existing local WAV file
  Future<void> transcribeRecordedFile(String path) async {
    final ctx = navigatorKey.currentContext;
    if (ctx == null) {
      loggingService.logError('[VoiceTranscriptionService] transcribeRecordedFile => no context');
      return;
    }
    final loc = AppLocalizations.of(ctx)!;

    try {
      final fileBytes = await File(path).readAsBytes();
      loggingService.logInfo('[VoiceTranscriptionService] Sending existing WAV to Whisper...');
      final transcript = await localWhisperApi.transcribeAudio(
        audioBytes: fileBytes,
        fileName: 'recorded_audio.wav',
      );
      _finalTranscript = transcript;
      _partialTranscript = transcript;
      loggingService.logInfo('[VoiceTranscriptionService] Final transcript: $_finalTranscript');
    } catch (e, st) {
      loggingService.logError('[VoiceTranscriptionService] Whisper transcription failed: $e\n$st');
      _finalTranscript = '';

      // Show popup
      await _showErrorDialog(
        title: loc.voiceErrorTranscriptionTitle,
        message: loc.voiceErrorTranscriptionBody,
        semanticLabel: loc.voiceErrorTranscriptionSemanticLabel,
      );
    }
    notifyListeners();
  }

  // -------------------------------------------------------------------------
  // Chunk-based streaming (Optional)
  // -------------------------------------------------------------------------
  /// Starts chunk-based recording
  Future<void> startChunkedRecording() async {
    final ctx = navigatorKey.currentContext;
    if (ctx == null) {
      loggingService.logError('[VoiceTranscriptionService] startChunkedRecording => no context');
      return;
    }
    final loc = AppLocalizations.of(ctx)!;

    if (_recorder.isRecording) {
      loggingService.logWarning('[VoiceTranscriptionService] Already chunk-recording!');
      return;
    }

    _partialTranscript = '';
    _finalTranscript = '';
    _audioBuffer.clear();

    try {
      await _recorder.startRecorder(
        toStream: _chunkController.sink, // Now a StreamSink<Uint8List>
        codec: Codec.pcm16,
        sampleRate: 16000,
        numChannels: 1,
      );

      _isRecording = true;
      loggingService.logInfo('[VoiceTranscriptionService] Chunked recording started.');

      _recordingSubscription = _chunkController.stream.listen(
            (chunk) async {
          // chunk is a Uint8List
          _audioBuffer.addAll(chunk);
          if (_audioBuffer.length >= 4096) {
            final chunkCopy = List<int>.from(_audioBuffer);
            _audioBuffer.clear();
            await _transcribeChunk(chunkCopy);
          }
        },
        onError: (error) {
          loggingService.logError('[VoiceTranscriptionService] Stream error: $error');
        },
      );
    } catch (e, st) {
      loggingService.logError(
        '[VoiceTranscriptionService] Error starting chunked recorder: $e\n$st',
      );
      _isRecording = false;
      notifyListeners();

      await _showErrorDialog(
        title: loc.voiceErrorRecorderStartTitle,
        message: loc.voiceErrorRecorderStartBody,
        semanticLabel: loc.voiceErrorRecorderStartSemanticLabel,
      );
    }
  }

  /// Internal helper to transcribe chunk data
  Future<void> _transcribeChunk(List<int> pcmBytes) async {
    try {
      final partialResult = await localWhisperApi.transcribeAudio(
        audioBytes: pcmBytes,
        fileName: 'partial_chunk.wav',
      );
      _partialTranscript = partialResult;
      loggingService.logInfo('[VoiceTranscriptionService] Partial transcript: $_partialTranscript');
      notifyListeners();
    } catch (e, st) {
      loggingService.logError('[VoiceTranscriptionService] Partial transcription failed: $e\n$st');
      // Optionally show a partial error dialog if desired
    }
  }

  /// Stops chunk-based recording
  Future<void> stopChunkedRecording() async {
    final ctx = navigatorKey.currentContext;
    if (ctx == null) {
      loggingService.logError('[VoiceTranscriptionService] stopChunkedRecording => no context');
      return;
    }
    final loc = AppLocalizations.of(ctx)!;

    if (!_recorder.isRecording) {
      loggingService.logWarning('[VoiceTranscriptionService] Not recording chunked mode');
      return;
    }

    try {
      await _recorder.stopRecorder();
      _isRecording = false;
      loggingService.logInfo('[VoiceTranscriptionService] Chunked recording stopped.');

      // Process leftover audio, if any
      if (_audioBuffer.isNotEmpty) {
        final leftover = List<int>.from(_audioBuffer);
        _audioBuffer.clear();
        await _transcribeChunk(leftover);
      }
    } catch (e, st) {
      loggingService.logError('[VoiceTranscriptionService] Error stopping chunked: $e\n$st');
      _isRecording = false;

      await _showErrorDialog(
        title: loc.voiceErrorRecorderStopTitle,
        message: loc.voiceErrorRecorderStopBody,
        semanticLabel: loc.voiceErrorRecorderStopSemanticLabel,
      );
    }
    notifyListeners();
  }

  // -------------------------------------------------------------------------
  // Cleanup
  // -------------------------------------------------------------------------
  @override
  void dispose() {
    // Cancel timer if it's still active
    _autoStopTimer?.cancel();
    _autoStopTimer = null;

    _recordingSubscription?.cancel();
    _chunkController.close();
    _recorder.closeRecorder();
    loggingService.logInfo('[VoiceTranscriptionService] Recorder closed.');
    super.dispose();
  }
}
