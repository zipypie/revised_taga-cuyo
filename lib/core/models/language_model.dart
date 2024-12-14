class LanguagePair {
  String language1;
  String language2;

  // Regular constructor
  LanguagePair({required this.language1, required this.language2});

  // Factory constructor to create a LanguagePair with default values
  factory LanguagePair.defaultPair() {
    return LanguagePair(language1: 'Tagalog', language2: 'Cuyonon');
  }

  // Method to swap the languages
  void swap() {
    String temp = language1;
    language1 = language2;
    language2 = temp;
  }

  // Method to get the current language pair
  List<String> getCurrentLanguages() {
    return [language1, language2];
  }
}
