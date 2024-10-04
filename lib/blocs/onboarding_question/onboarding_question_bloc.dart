import 'dart:async';

import 'package:bloc/bloc.dart';

import '../../repositories/onboarding_repository.dart';
import 'onboarding_question_event.dart';
import 'onboarding_question_state.dart';

class OnboardingQuestionBloc extends Bloc<OnboardingQuestionEvent, OnboardingQuestionState> {
  final OnboardingRepository onboardingRepository;
  Timer? _timer;
  int _recordingDuration = 0;

  OnboardingQuestionBloc({required this.onboardingRepository}) : super(OnboardingQuestionState.init()) {
    on<InitEvent>(_init);
    on<SubmitTextAnswerEvent>(_submitTextAnswer);
    on<RecordAudioEvent>(_recordAudio);
    on<RecordVideoEvent>(_recordVideo);
    on<UpdateRecordingDurationEvent>(_updateRecordingDuration);
    on<StopRecordingEvent>(_stopRecording);
    on<UpdateTextAnswerEvent>(_updateTextAnswer); // Handle new text update event
  }

  void _init(InitEvent event, Emitter<OnboardingQuestionState> emit) async {
    emit(state.copyWith()); // Use copyWith instead of clone
  }

  void _submitTextAnswer(SubmitTextAnswerEvent event, Emitter<OnboardingQuestionState> emit) {
    emit(state.copyWith(textAnswer: event.answer));
  }

  void _recordAudio(RecordAudioEvent event, Emitter<OnboardingQuestionState> emit) async {
    emit(state.copyWith(isRecording: true));
    _recordingDuration = 0;
    _startTimer(); // Start the timer
    try {
      final audioPath = await onboardingRepository.recordAudio();
      emit(state.copyWith(audioAnswer: audioPath));
    } catch (e) {
      emit(state.copyWith(errorMessage: 'Failed to record audio', isRecording: false));
      _stopTimer();
    }
  }

  void _updateRecordingDuration(UpdateRecordingDurationEvent event, Emitter<OnboardingQuestionState> emit) {
    emit(state.copyWith(recordingDuration: event.duration));
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (Timer timer) {
      _recordingDuration++;
      print("Recording Duration: $_recordingDuration"); // Debugging line
      add(UpdateRecordingDurationEvent(_recordingDuration));
    });
  }

  void _stopTimer() {
    _timer?.cancel();
  }

  void _stopRecording(StopRecordingEvent event, Emitter<OnboardingQuestionState> emit) async {
    await onboardingRepository.stopRecording(); // Stop the recording
    _stopTimer();
    emit(state.copyWith(isRecording: false));
  }

  void _recordVideo(RecordVideoEvent event, Emitter<OnboardingQuestionState> emit) async {
    emit(state.copyWith(isRecording: true));
    try {
      final videoPath = await onboardingRepository.recordVideo();
      emit(state.copyWith(videoAnswer: videoPath, isRecording: false));
    } catch (e) {
      emit(state.copyWith(errorMessage: 'Failed to record video', isRecording: false));
    }
  }

  void _updateTextAnswer(UpdateTextAnswerEvent event, Emitter<OnboardingQuestionState> emit) {
    emit(state.copyWith(textAnswer: event.answer)); // Update the text answer in the state
  }
}
