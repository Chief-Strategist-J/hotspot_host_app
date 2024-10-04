class OnboardingQuestionState {
  final String? audioAnswer;
  final String? videoAnswer;
  final String? textAnswer;
  final bool isRecording;
  final int recordingDuration;  // New field for the counter
  final String? errorMessage;

  OnboardingQuestionState({
    this.audioAnswer,
    this.videoAnswer,
    this.textAnswer,
    this.isRecording = false,
    this.recordingDuration = 0,  // Initialize with 0
    this.errorMessage,
  });

  // Add recordingDuration to copyWith
  OnboardingQuestionState copyWith({
    String? audioAnswer,
    String? videoAnswer,
    String? textAnswer,
    bool? isRecording,
    int? recordingDuration,
    String? errorMessage,
  }) {
    return OnboardingQuestionState(
      audioAnswer: audioAnswer ?? this.audioAnswer,
      videoAnswer: videoAnswer ?? this.videoAnswer,
      textAnswer: textAnswer ?? this.textAnswer,
      isRecording: isRecording ?? this.isRecording,
      recordingDuration: recordingDuration ?? this.recordingDuration,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  factory OnboardingQuestionState.init() {
    return OnboardingQuestionState();
  }
}
