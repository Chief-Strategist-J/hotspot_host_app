abstract class OnboardingQuestionEvent {}

class InitEvent extends OnboardingQuestionEvent {}

class SubmitTextAnswerEvent extends OnboardingQuestionEvent {
  final String answer;

  SubmitTextAnswerEvent(this.answer);
}

class RecordAudioEvent extends OnboardingQuestionEvent {}

class RecordVideoEvent extends OnboardingQuestionEvent {}

class StopRecordingEvent extends OnboardingQuestionEvent {}

class UpdateRecordingDurationEvent extends OnboardingQuestionEvent {
  final int duration;

  UpdateRecordingDurationEvent(this.duration);
}

class UpdateTextAnswerEvent extends OnboardingQuestionEvent {
  final String answer;

  UpdateTextAnswerEvent(this.answer);

  @override
  List<Object> get props => [answer];
}
