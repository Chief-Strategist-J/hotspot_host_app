import 'package:flutter/material.dart';
import 'package:hotspot_host_app/core/utils.dart';
import 'package:hotspot_host_app/screens/onboarding_question_screen.dart';

class NextButton extends StatelessWidget {
  final void Function()? onTap;

  const NextButton({super.key, this.onTap});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: GestureDetector(
        onTap: () {
          if (onTap != null) {
            onTap!.call();
          } else {
            Navigator.of(context).push(MaterialPageRoute(
              builder: (context) {
                return const OnboardingQuestionScreen();
              },
            ));
          }
        },
        child: Container(
          height: 50,
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [
                Color(0xFF101010),
                Color(0xFF232323), // 100% color
                Color(0xFF101010),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              width: 1, // Stroke inside
              color: const Color(0xFF222222), // Inside stroke color
            ),
            boxShadow: [
              BoxShadow(
                color: const Color(0xFF999999).withOpacity(0.4),
                blurRadius: 5.0,
                spreadRadius: 0.5,
                offset: const Offset(0.0, 1.0),
              ),
            ],
          ),
          child: Center(
            child: Text(
              'Next',
              style: defineRegularTextStyle(),
            ),
          ),
        ),
      ),
    );
  }
}
