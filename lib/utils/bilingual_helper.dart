/// Helper utility for handling bilingual data across the app
/// 
/// Uses the global language setting to determine which field to use:
/// - If language is English ('en') → use English field
/// - If language is Local (non-'en') → use local field with English fallback
/// 
/// This ensures consistent bilingual behavior everywhere in the app.
library;

class BilingualHelper {
  /// Get the appropriate field value based on current language
  /// 
  /// [englishValue] - The English language value
  /// [localValue] - The local language value (Telugu, etc.)
  /// [currentLangCode] - Current language code ('en' or 'te', etc.)
  /// 
  /// Returns local value if language is local and value exists, otherwise English
  static String getLocalizedValue({
    required String? englishValue,
    required String? localValue,
    required String currentLangCode,
  }) {
    // If language is English, always return English
    if (currentLangCode == 'en') {
      return englishValue ?? '';
    }
    
    // For local language: use local value if available, fallback to English
    if (localValue != null && localValue.trim().isNotEmpty) {
      return localValue;
    }
    
    return englishValue ?? '';
  }
  
  /// Get voter name based on current language
  static String getVoterName(String? name, String? nameLocal, String langCode) {
    return getLocalizedValue(
      englishValue: name,
      localValue: nameLocal,
      currentLangCode: langCode,
    );
  }
  
  /// Get address based on current language
  static String getAddress(String? address, String? addressLocal, String langCode) {
    return getLocalizedValue(
      englishValue: address,
      localValue: addressLocal,
      currentLangCode: langCode,
    );
  }
  
  /// Get section name based on current language
  static String getSectionName(String? sectionName, String? sectionNameLocal, String langCode) {
    return getLocalizedValue(
      englishValue: sectionName,
      localValue: sectionNameLocal,
      currentLangCode: langCode,
    );
  }
  
  /// Get relation name based on current language
  static String getRelationName(String? relationName, String? relationNameLocal, String langCode) {
    return getLocalizedValue(
      englishValue: relationName,
      localValue: relationNameLocal,
      currentLangCode: langCode,
    );
  }
  
  /// Get survey title based on current language
  static String getSurveyTitle(String? title, String? titleLocal, String langCode) {
    return getLocalizedValue(
      englishValue: title,
      localValue: titleLocal,
      currentLangCode: langCode,
    );
  }
  
  /// Get survey description based on current language
  static String getSurveyDescription(String? description, String? descriptionLocal, String langCode) {
    return getLocalizedValue(
      englishValue: description,
      localValue: descriptionLocal,
      currentLangCode: langCode,
    );
  }
  
  /// Get survey question text based on current language
  static String getQuestionText(String? text, String? textLocal, String langCode) {
    return getLocalizedValue(
      englishValue: text,
      localValue: textLocal,
      currentLangCode: langCode,
    );
  }
  
  /// Get survey option text based on current language
  static String getOptionText(String? text, String? textLocal, String langCode) {
    return getLocalizedValue(
      englishValue: text,
      localValue: textLocal,
      currentLangCode: langCode,
    );
  }
}
