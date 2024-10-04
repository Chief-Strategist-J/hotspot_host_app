import 'package:equatable/equatable.dart';
import 'package:hotspot_host_app/models/experience.dart';

class ExperienceSelectionState extends Equatable {
  final bool isLoading;
  final List<Experience> experiences;
  final List<int> selectedExperiences;
  final String errorMessage;
  final String description; // New field for the text input

  const ExperienceSelectionState({
    required this.isLoading,
    required this.experiences,
    required this.selectedExperiences,
    required this.errorMessage,
    this.description = '', // Initialize with an empty string
  });

  factory ExperienceSelectionState.init() {
    return ExperienceSelectionState(
      isLoading: false,
      experiences: [],
      selectedExperiences: [],
      errorMessage: '',
      description: '', // Initialize with an empty string
    );
  }

  ExperienceSelectionState copyWith({
    bool? isLoading,
    List<Experience>? experiences,
    List<int>? selectedExperiences,
    String? errorMessage,
    String? description, // Include the new field
  }) {
    return ExperienceSelectionState(
      isLoading: isLoading ?? this.isLoading,
      experiences: experiences ?? this.experiences,
      selectedExperiences: selectedExperiences ?? this.selectedExperiences,
      errorMessage: errorMessage ?? this.errorMessage,
      description: description ?? this.description, // Update the new field
    );
  }

  @override
  List<Object?> get props => [isLoading, experiences, selectedExperiences, errorMessage, description];
}
