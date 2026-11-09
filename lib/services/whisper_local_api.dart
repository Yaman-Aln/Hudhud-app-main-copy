// lib/services/whisper_local_api.dart

import 'dart:convert';
import 'package:http/http.dart' as http;

/// A simple client that calls your self-hosted FastAPI endpoint for Whisper transcription.
///
/// Example endpoint: https://transcribe.hudhudquran.com/transcribe
///
/// Ensure your FastAPI server returns JSON in the shape:
///   { "transcription": "..." }
class LocalWhisperApi {
  /// For example: "https://transcribe.hudhudquran.com/transcribe"
  final String serverUrl;

  LocalWhisperApi({
    required this.serverUrl,
  });

  /// Send a single audio file (in bytes) to your FastAPI server.
  ///
  /// The server expects multipart/form-data with field name "file" (see model.py).
  /// Returns the transcription string on success.
  Future<String> transcribeAudio({
    required List<int> audioBytes,
    String fileName = 'audio.wav',
  }) async {
    final uri = Uri.parse(serverUrl);
    final request = http.MultipartRequest('POST', uri)
      ..files.add(
        http.MultipartFile.fromBytes(
          'file',
          audioBytes,
          filename: fileName,
        ),
      );

    // If your FastAPI requires any auth headers, add them here:
    // request.headers['Authorization'] = 'Bearer <your token>';
    // request.headers['Content-Type'] = 'multipart/form-data'; // Typically auto-set

    final streamedResponse = await request.send();
    final responseBody = await streamedResponse.stream.toBytes();
    final decodedBody = utf8.decode(responseBody);

    if (streamedResponse.statusCode == 200) {
      // The expected JSON response: { "transcription": "some text" }
      final Map<String, dynamic> parsed = json.decode(decodedBody);
      return parsed['transcription'] ?? '';
    } else {
      throw Exception(
        'Transcription failed. Status: ${streamedResponse.statusCode}\nBody: $decodedBody',
      );
    }
  }
}
