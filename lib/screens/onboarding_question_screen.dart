import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hotspot_host_app/blocs/onboarding_question/onboarding_question_bloc.dart';
import 'package:hotspot_host_app/blocs/onboarding_question/onboarding_question_event.dart';
import 'package:hotspot_host_app/blocs/onboarding_question/onboarding_question_state.dart';
import 'package:hotspot_host_app/core/constants.dart';
import 'package:hotspot_host_app/core/utils.dart';
import 'package:hotspot_host_app/screens/widgets/next_button.dart';
import 'package:hotspot_host_app/screens/widgets/wave.dart';

class OnboardingQuestionScreen extends StatelessWidget {
  const OnboardingQuestionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OnboardingQuestionBloc, OnboardingQuestionState>(
      builder: (context, state) {
        return Scaffold(
          backgroundColor: Colors.black,
          appBar: AppBar(
            leading: IconButton(
              icon: const Icon(Icons.arrow_back, color: AppColors.white),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
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
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 24),
                  _buildQuestion(),
                  const SizedBox(height: 16),
                  _buildAnswerField(context),
                  const Spacer(),
                  _buildRecordingIndicator(state), // Updated indicator to show duration
                  const SizedBox(height: 16),
                  _buildBottomButtons(context, state.isRecording),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildQuestion() {
    return Text(
      'Why do you want to host with us?',
      style: boldTextStyle(),
    );
  }

  Widget _buildAnswerField(BuildContext context) {
    return Expanded(
      child: TextField(
        style: TextStyle(color: AppColors.white),
        maxLines: null,
        expands: true,
        textAlignVertical: TextAlignVertical.top,
        decoration: InputDecoration(
          hintText: 'Describe your perfect hotspot',
        ),
        onChanged: (value) {
          context.read<OnboardingQuestionBloc>().add(UpdateTextAnswerEvent(value)); // Dispatch event
        },
      ),
    );
  }

  Widget _buildRecordingIndicator(OnboardingQuestionState state) {
    if (!state.isRecording) return const SizedBox.shrink(); // Hide when not recording

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.grey[900],
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        children: [
          Text('Recording...', style: defineRegularTextStyle()),
          const SizedBox(height: 8),
          Row(
            mainAxisSize: MainAxisSize.min, // Minimize space
            children: [
              const SpinKitWave(color: Colors.blue, itemCount: 60, type: SpinKitWaveType.center, size: 190), // Adjust size for visibility
              const SizedBox(width: 8),
              Text('${state.recordingDuration}s', style: defineRegularTextStyle()), // Display the timer
            ],
          ),
          const SizedBox(height: 8),
        ],
      ),
    );
  }

  Widget _buildBottomButtons(BuildContext context, bool isRecording) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            if (!isRecording) ...[
              IconButton(
                icon: const Icon(Icons.mic), // Mic icon for recording
                onPressed: () {
                  context.read<OnboardingQuestionBloc>().add(RecordAudioEvent()); // Start audio recording
                },
              ),
              const SizedBox(width: 16),
              IconButton(
                icon: const Icon(Icons.videocam), // Camera icon for video recording
                onPressed: () {
                  context.read<OnboardingQuestionBloc>().add(RecordVideoEvent()); // Start video recording
                },
              ),
            ] else ...[
              IconButton(
                icon: const Icon(Icons.stop), // Stop icon for stopping recording
                onPressed: () {
                  context.read<OnboardingQuestionBloc>().add(StopRecordingEvent()); // Stop recording
                },
              ),
            ],
          ],
        ),
        Expanded(
          child: NextButton(
            onTap: () {},
          ),
        ), // Next button to move forward
      ],
    );
  }
}
