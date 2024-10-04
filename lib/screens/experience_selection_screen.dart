import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hotspot_host_app/blocs/experience_selection/experience_selection_bloc.dart';
import 'package:hotspot_host_app/blocs/experience_selection/experience_selection_event.dart';
import 'package:hotspot_host_app/blocs/experience_selection/experience_selection_state.dart';
import 'package:hotspot_host_app/core/constants.dart';
import 'package:hotspot_host_app/screens/widgets/next_button.dart';
import 'package:hotspot_host_app/screens/widgets/postage_stamp.dart';

import '../core/utils.dart';

class ExperienceSelectionScreen extends StatelessWidget {
  const ExperienceSelectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<ExperienceSelectionBloc>().add(FetchExperiencesEvent());

    return Scaffold(
      appBar: AppBar(
        leading: const Icon(Icons.arrow_back, color: AppColors.white),
        backgroundColor: AppColors.backgroundColor,
        title: SvgPicture.asset(AppImages.lineImage),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.close, color: AppColors.white),
            onPressed: () {},
          ),
        ],
      ),
      body: SafeArea(
        child: Stack(
          fit: StackFit.expand,
          children: [
            Container(color: AppColors.black),
            SvgPicture.asset(
              AppImages.backgroundImage,
              fit: BoxFit.cover,
              width: double.infinity,
              height: double.infinity,
            ),
            BlocBuilder<ExperienceSelectionBloc, ExperienceSelectionState>(
              builder: (context, state) {
                if (state.isLoading) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (state.errorMessage.isNotEmpty) {
                  return Center(
                    child: Text(
                      state.errorMessage,
                      style: defineRegularTextStyle(),
                    ),
                  );
                }

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Expanded(child: SizedBox()),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Text(
                        'What kind of experiences do you want to host?',
                        style: boldTextStyle(),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Text(
                        'Tell us about your intent and what motivates you to create experiences.',
                        style: defineRegularTextStyle(),
                      ),
                    ),
                    const SizedBox(height: 16),
                    SizedBox(
                      height: 150,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        itemCount: state.experiences.length,
                        itemBuilder: (context, index) {
                          final experience = state.experiences[index];
                          final isSelected = state.selectedExperiences.contains(experience.id);

                          return GestureDetector(
                            onTap: () {
                              if (isSelected) {
                                context.read<ExperienceSelectionBloc>().add(DeselectExperienceEvent(experience.id));
                              } else {
                                context.read<ExperienceSelectionBloc>().add(SelectExperienceEvent(experience.id));
                              }
                            },
                            child: Container(
                              width: 150,
                              margin: const EdgeInsets.only(right: 16),
                              child: SingleChildScrollView(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    PostageStamp(
                                      text: experience.name,
                                      imagePath: isSelected ? experience.imageUrl : experience.iconUrl,
                                      selected: !isSelected,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: TextField(
                          style: const TextStyle(color: AppColors.white),
                          maxLength: 250,
                          maxLines: null,
                          expands: true,
                          textAlignVertical: TextAlignVertical.top,
                          decoration: const InputDecoration(
                            hintText: 'Describe your perfect hotspot',
                          ),
                          onChanged: (value) {
                            context.read<ExperienceSelectionBloc>().add(UpdateDescriptionEvent(value)); // Dispatch event
                          },
                        ),
                      ),
                    ),
                    const NextButton(),
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
