import 'package:flutter/material.dart';

/// A generic widget that can display either static text or text from an object
/// that has a text property (like business name, product name, etc.)
class DynamicText<T> extends StatelessWidget {
  final T? object;  // Optional object that contains the text
  final String staticText;  // Required static text as fallback
  final TextStyle? style;    // Optional text style
  final TextAlign? textAlign; // Optional text alignment
  final String Function(T? object) textExtractor; // Function to extract text from object

  const DynamicText({
    super.key,
    this.object,
    required this.staticText,
    this.style,
    this.textAlign,
    required this.textExtractor,
  });

  @override
  Widget build(BuildContext context) {
    // Use object's text if available, otherwise use static text
    final displayText = object != null ? textExtractor(object) : staticText;

    return Text(
      displayText,
      style: style,
      textAlign: textAlign,
    );
  }
} 