import 'package:equatable/equatable.dart';
import '../entities/words_entity.dart';

class WordsModel extends Equatable {
  final String wordId; // Firestore document ID
  final String word;
  final String translated;
  final String imagePath;
  final List<String> options; // Array of options

  const WordsModel({
    required this.wordId,
    required this.word,
    required this.translated,
    required this.imagePath,
    required this.options,
  });

  // Getter for the word field
  String get wordValue => word;

  @override
  List<Object?> get props => [
        wordId,
        word,
        translated,
        imagePath,
        options,
      ];

  /// Empty WordsModel Constant
  static const empty = WordsModel(
    wordId: '',
    word: '',
    translated: '',
    imagePath: '',
    options: [], // Empty list of options
  );

  /// Copy Method
  WordsModel copyWith({
    String? wordId,
    String? word,
    String? translated,
    String? imagePath,
    List<String>? options,
  }) {
    return WordsModel(
      wordId: wordId ?? this.wordId,
      word: word ?? this.word,
      translated: translated ?? this.translated,
      imagePath: imagePath ?? this.imagePath,
      options: options ?? this.options,
    );
  }

  /// Check if WordsModel is Empty
  bool get isEmpty => this == WordsModel.empty;

  /// Check if WordsModel is Not Empty
  bool get isNotEmpty => this != WordsModel.empty;

  /// Convert to WordEntity
  WordEntity toEntity() {
    return WordEntity(
      wordId: wordId,
      word: word,
      translated: translated,
      imagePath: imagePath,
      options: options,
    );
  }

  /// Convert from WordEntity
  static WordsModel fromEntity(WordEntity entity) {
    return WordsModel(
      wordId: entity.wordId,
      word: entity.word,
      translated: entity.translated,
      imagePath: entity.imagePath,
      options: entity.options,
    );
  }
}
