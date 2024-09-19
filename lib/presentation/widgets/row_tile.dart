import 'package:flutter/material.dart';

/// Function that returns a [RichText] widget with a leading text and a trailing text.
RichText rowRichText(String leadingText, String trailingText,
    {TextStyle? leadingStyle, TextStyle? trailingStyle}) {
  return RichText(
    text: TextSpan(text: leadingText, style: leadingStyle, children: [
      TextSpan(
        text: trailingText,
        style: trailingStyle,
      ),
    ]),
  );
}
