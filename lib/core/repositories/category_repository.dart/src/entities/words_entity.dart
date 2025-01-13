import 'dart:convert';

import 'package:equatable/equatable.dart';

class WordEntity extends Equatable {
  final String wordId; // This will be the Firestore document ID
  final String word;
  final String translated;
  final String imagePath;
  final List<String> options; // Array of options

  const WordEntity({
    required this.wordId, // This will be the document ID
    required this.word,
    required this.translated,
    required this.imagePath,
    required this.options,
  });

  @override
  List<Object?> get props => [
        wordId,
        word,
        translated,
        imagePath,
        options,
      ];

  /// Copy Method
  WordEntity copyWith({
    String? wordId,
    String? word,
    String? translated,
    String? imagePath,
    List<String>? options,
  }) {
    return WordEntity(
      wordId: wordId ?? this.wordId,
      word: word ?? this.word,
      translated: translated ?? this.translated,
      imagePath: imagePath ?? this.imagePath,
      options: options ?? this.options,
    );
  }

  /// Convert to Map
  Map<String, dynamic> toMap() {
    return {
      'word': word,
      'translated': translated,
      'image_path': imagePath,
      'options': options,
    };
  }

  /// Create from Map
  factory WordEntity.fromMap(String wordId, Map<String, dynamic> map) {
    return WordEntity(
      wordId: wordId, // Use the provided wordId as the Firestore document ID
      word: map['word'] as String,
      translated: map['translated'] as String,
      imagePath: map['image_path'] as String,
      options: List<String>.from(map['options'] as List),
    );
  }

  /// Convert to JSON
  String toJson() => json.encode(toMap());

  /// Create from JSON
  factory WordEntity.fromJson(String source) {
    return WordEntity.fromMap(
      source, // Assuming source contains the wordId in some way
      json.decode(source) as Map<String, dynamic>,
    );
  }
}
