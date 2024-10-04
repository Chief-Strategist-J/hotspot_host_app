import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hotspot_host_app/core/constants.dart';
import 'package:hotspot_host_app/core/utils.dart';

import 'blocs/experience_selection/experience_selection_bloc.dart';
import 'blocs/onboarding_question/onboarding_question_bloc.dart';
import 'repositories/experience_repository.dart';
import 'repositories/onboarding_repository.dart';
import 'screens/experience_selection_screen.dart';
import 'screens/onboarding_question_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<ExperienceSelectionBloc>(
          create: (context) => ExperienceSelectionBloc(
            experienceRepository: ExperienceRepository(),
          ),
        ),
        BlocProvider<OnboardingQuestionBloc>(
          create: (context) => OnboardingQuestionBloc(
            onboardingRepository: OnboardingRepository(),
          ),
        ),
      ],
      child: MaterialApp(
        title: 'Hotspot Host App',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primaryColor: AppColors.backgroundColor,
          iconTheme: const IconThemeData(
            color: Colors.white, // Default icon color
          ),
          textTheme: const TextTheme(),
          inputDecorationTheme: InputDecorationTheme(
            hintStyle: inputTextStyle(),
            filled: true,
            fillColor: AppColors.white.withOpacity(0.05),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(24),
              borderSide: const BorderSide(color: Colors.transparent),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(24),
              borderSide: const BorderSide(color: Colors.transparent),
            ),
          ),
        ),
        initialRoute: '/',
        routes: {
          '/': (context) => ExperienceSelectionScreen(),
          '/onboarding': (context) => OnboardingQuestionScreen(),
        },
      ),
    );
  }
}
