import 'package:equatable/equatable.dart';

// Base class for all events
abstract class ExperienceSelectionEvent extends Equatable {
  const ExperienceSelectionEvent();

  @override
  List<Object> get props => [];
}

// Event to initialize the state
class InitEvent extends ExperienceSelectionEvent {}

// Event to fetch experiences from the API
class FetchExperiencesEvent extends ExperienceSelectionEvent {}

// Event for selecting an experience
class SelectExperienceEvent extends ExperienceSelectionEvent {
  final int experienceId;

  const SelectExperienceEvent(this.experienceId);

  @override
  List<Object> get props => [experienceId];
}

// Event for deselecting an experience
class DeselectExperienceEvent extends ExperienceSelectionEvent {
  final int experienceId;

  const DeselectExperienceEvent(this.experienceId);

  @override
  List<Object> get props => [experienceId];
}

class UpdateDescriptionEvent extends ExperienceSelectionEvent {
  final String description;

  UpdateDescriptionEvent(this.description);

  @override
  List<Object> get props => [description];
}
