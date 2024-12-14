class TranslationRequest {
  final String sentence;
  final String sourceLang;
  final String targetLang;

  TranslationRequest({
    required this.sentence,
    required this.sourceLang,
    required this.targetLang,
  });

  // Convert the object to JSON
  Map<String, dynamic> toJson() {
    return {
      "sentence": sentence,
      "source_lang": sourceLang,
      "target_lang": targetLang,
    };
  }

  // Create an object from JSON (optional if needed in future)
  factory TranslationRequest.fromJson(Map<String, dynamic> json) {
    return TranslationRequest(
      sentence: json["sentence"] ?? "",
      sourceLang: json["source_lang"] ?? "",
      targetLang: json["target_lang"] ?? "",
    );
  }
}
