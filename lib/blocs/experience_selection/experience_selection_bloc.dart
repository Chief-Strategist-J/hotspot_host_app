import 'package:bloc/bloc.dart';

import '../../repositories/experience_repository.dart';
import 'experience_selection_event.dart';
import 'experience_selection_state.dart';

class ExperienceSelectionBloc extends Bloc<ExperienceSelectionEvent, ExperienceSelectionState> {
  final ExperienceRepository experienceRepository;

  ExperienceSelectionBloc({required this.experienceRepository}) : super(ExperienceSelectionState.init()) {
    on<InitEvent>(_init);
    on<SelectExperienceEvent>(_selectExperience);
    on<DeselectExperienceEvent>(_deselectExperience);
    on<FetchExperiencesEvent>(_fetchExperiences);
    on<UpdateDescriptionEvent>(_updateDescription); // Handle the new event
  }

  // Initialize the bloc state
  void _init(InitEvent event, Emitter<ExperienceSelectionState> emit) async {
    emit(ExperienceSelectionState.init());
  }

  // Fetch experiences from the API
  void _fetchExperiences(FetchExperiencesEvent event, Emitter<ExperienceSelectionState> emit) async {
    try {
      emit(state.copyWith(isLoading: true, errorMessage: '')); // Show loading state
      final experiences = await experienceRepository.fetchExperiences();
      emit(state.copyWith(experiences: experiences, isLoading: false)); // Update with fetched experiences
    } catch (e) {
      emit(state.copyWith(isLoading: false, errorMessage: 'Failed to fetch experiences')); // Handle error
    }
  }

  void _selectExperience(SelectExperienceEvent event, Emitter<ExperienceSelectionState> emit) {
    if (!state.selectedExperiences.contains(event.experienceId)) {
      final updatedSelected = List<int>.from(state.selectedExperiences)..add(event.experienceId);
      emit(state.copyWith(selectedExperiences: updatedSelected)); // Update selected experiences
    }
  }

  void _deselectExperience(DeselectExperienceEvent event, Emitter<ExperienceSelectionState> emit) {
    if (state.selectedExperiences.contains(event.experienceId)) {
      final updatedSelected = List<int>.from(state.selectedExperiences)..remove(event.experienceId);
      emit(state.copyWith(selectedExperiences: updatedSelected)); // Update after deselecting
    }
  }
  void _updateDescription(UpdateDescriptionEvent event, Emitter<ExperienceSelectionState> emit) {
    emit(state.copyWith(description: event.description)); // Update the description in state
  }
}
