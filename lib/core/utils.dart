import 'package:flutter/material.dart';

TextStyle boldTextStyle({double? height}) {
  return const TextStyle(
    fontFamily: 'Space Grotesk',
    fontWeight: FontWeight.bold,
    fontSize: 24,
    height: 32 / 16,
    letterSpacing: -0.02 * 16,
    color: Color(0xFFFFFFFF),
  );
}

TextStyle defineRegularTextStyle() {
  return const TextStyle(
    fontFamily: 'Space Grotesk',
    fontWeight: FontWeight.normal,
    fontSize: 14,
    height: 20 / 14,
    color: Color(0x80FFFFFF), // White color with 48% opacity
  );
}

TextStyle inputTextStyle() {
  return TextStyle(
    fontFamily: 'Space Grotesk', // Use the custom font family
    fontWeight: FontWeight.normal, // Regular weight
    fontSize: 20, // Size 20
    height: 28 / 20, // Line height ratio
    color: Colors.white.withOpacity(0.16), // White color with 16% opacity
    letterSpacing: -0.01 * 20, // Adjust letter spacing (1% of font size)
  );
}