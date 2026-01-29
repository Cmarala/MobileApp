import 'package:flutter/material.dart';

/// Enhanced enum for voter favorability matching the 5-tier strategy
enum VoterFavorability {
  veryStrong(Colors.green, 'Very Strong', 'very_strong'),
  strong(Color(0xFF81C784), 'Strong', 'strong'), // Lighter green
  neutral(Colors.orange, 'Neutral', 'neutral'),
  leanOther(Colors.blueGrey, 'Lean Other', 'lean_other'),
  notKnown(Colors.grey, 'Not Known', 'not_known');

  final Color color;
  final String label;
  final String databaseValue;

  const VoterFavorability(this.color, this.label, this.databaseValue);

  /// Convert from string value (database representation)
  static VoterFavorability fromString(String? value) {
    switch (value?.toLowerCase()) {
      case 'very_strong':
        return VoterFavorability.veryStrong;
      case 'strong':
        return VoterFavorability.strong;
      case 'neutral':
        return VoterFavorability.neutral;
      case 'lean_other':
        return VoterFavorability.leanOther;
      case 'not_known':
      default:
        return VoterFavorability.notKnown;
    }
  }

  /// Convert to string value for database storage
  /// Using databaseValue to ensure underscore naming (e.g., 'very_strong')
  String toValue() => databaseValue;
}

/// Enhanced enum for gender remains the same
enum Gender {
  male('M', 'Male'),
  female('F', 'Female'),
  other('O', 'Other');

  final String code;
  final String label;

  const Gender(this.code, this.label);

  static Gender? fromString(String? value) {
    switch (value?.toUpperCase()) {
      case 'M':
        return Gender.male;
      case 'F':
        return Gender.female;
      case 'O':
        return Gender.other;
      default:
        return null;
    }
  }

  String toValue() => code;
}