import 'dart:async';

import 'package:flutter_sound/flutter_sound.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

class OnboardingRepository {
  final FlutterSoundRecorder _audioRecorder = FlutterSoundRecorder();
  final FlutterSoundPlayer _audioPlayer = FlutterSoundPlayer();

  OnboardingRepository();

  Future<void> init() async {
    // Request necessary permissions
    await _requestPermissions();

    // Ensure that the recorder is opened successfully
    try {
      await _audioRecorder.openRecorder();
      await _audioPlayer.openPlayer();
    } catch (e) {
      print("Error opening audio recorder/player: $e");
    }
  }

  Future<void> _requestPermissions() async {
    final status = await Permission.microphone.request();

    if (status != PermissionStatus.granted) {
      print('Microphone permission not granted');
      // Handle permission denial if necessary
    }
  }

  Future<String?> recordAudio() async {
    if (_audioRecorder.isRecording) {
      print('Audio is already recording.');
      return null; // Return early if already recording
    }

    await init(); // Ensure recorder is initialized

    final directory = await getApplicationDocumentsDirectory();
    final audioPath = '${directory.path}/audio_${DateTime.now().millisecondsSinceEpoch}.aac';

    try {
      await _audioRecorder.startRecorder(
        toFile: audioPath,
        codec: Codec.aacADTS,
      );
      print('Recording started');
    } catch (e) {
      print("Error starting audio recording: $e");
      return null; // Return null in case of error
    }

    return audioPath; // Return path when recording starts
  }

  Future<void> stopRecording() async {
    if (!_audioRecorder.isRecording) {
      print('No active recording to stop.');
      return; // No-op if not recording
    }

    try {
      await _audioRecorder.stopRecorder();
      print('Recording stopped');
    } catch (e) {
      print("Error stopping audio recording: $e");
    }
  }

  Future<String> recordVideo() async {
    final directory = await getApplicationDocumentsDirectory();
    final videoPath = '${directory.path}/video_${DateTime.now().millisecondsSinceEpoch}.mp4';
    return videoPath;
  }

  Future<void> close() async {
    await _audioRecorder.closeRecorder();
    await _audioPlayer.closePlayer();
  }
}
