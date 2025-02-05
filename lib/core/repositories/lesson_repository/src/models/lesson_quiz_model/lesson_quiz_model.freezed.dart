// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'lesson_quiz_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

LessonQuizModel _$LessonQuizModelFromJson(Map<String, dynamic> json) {
  return _LessonQuizModel.fromJson(json);
}

/// @nodoc
mixin _$LessonQuizModel {
  List<String> get options => throw _privateConstructorUsedError;
  String get translated => throw _privateConstructorUsedError;
  String get word => throw _privateConstructorUsedError;

  /// Serializes this LessonQuizModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of LessonQuizModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $LessonQuizModelCopyWith<LessonQuizModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $LessonQuizModelCopyWith<$Res> {
  factory $LessonQuizModelCopyWith(
          LessonQuizModel value, $Res Function(LessonQuizModel) then) =
      _$LessonQuizModelCopyWithImpl<$Res, LessonQuizModel>;
  @useResult
  $Res call({List<String> options, String translated, String word});
}

/// @nodoc
class _$LessonQuizModelCopyWithImpl<$Res, $Val extends LessonQuizModel>
    implements $LessonQuizModelCopyWith<$Res> {
  _$LessonQuizModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of LessonQuizModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? options = null,
    Object? translated = null,
    Object? word = null,
  }) {
    return _then(_value.copyWith(
      options: null == options
          ? _value.options
          : options // ignore: cast_nullable_to_non_nullable
              as List<String>,
      translated: null == translated
          ? _value.translated
          : translated // ignore: cast_nullable_to_non_nullable
              as String,
      word: null == word
          ? _value.word
          : word // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$LessonQuizModelImplCopyWith<$Res>
    implements $LessonQuizModelCopyWith<$Res> {
  factory _$$LessonQuizModelImplCopyWith(_$LessonQuizModelImpl value,
          $Res Function(_$LessonQuizModelImpl) then) =
      __$$LessonQuizModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({List<String> options, String translated, String word});
}

/// @nodoc
class __$$LessonQuizModelImplCopyWithImpl<$Res>
    extends _$LessonQuizModelCopyWithImpl<$Res, _$LessonQuizModelImpl>
    implements _$$LessonQuizModelImplCopyWith<$Res> {
  __$$LessonQuizModelImplCopyWithImpl(
      _$LessonQuizModelImpl _value, $Res Function(_$LessonQuizModelImpl) _then)
      : super(_value, _then);

  /// Create a copy of LessonQuizModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? options = null,
    Object? translated = null,
    Object? word = null,
  }) {
    return _then(_$LessonQuizModelImpl(
      options: null == options
          ? _value._options
          : options // ignore: cast_nullable_to_non_nullable
              as List<String>,
      translated: null == translated
          ? _value.translated
          : translated // ignore: cast_nullable_to_non_nullable
              as String,
      word: null == word
          ? _value.word
          : word // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$LessonQuizModelImpl implements _LessonQuizModel {
  const _$LessonQuizModelImpl(
      {required final List<String> options,
      required this.translated,
      required this.word})
      : _options = options;

  factory _$LessonQuizModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$LessonQuizModelImplFromJson(json);

  final List<String> _options;
  @override
  List<String> get options {
    if (_options is EqualUnmodifiableListView) return _options;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_options);
  }

  @override
  final String translated;
  @override
  final String word;

  @override
  String toString() {
    return 'LessonQuizModel(options: $options, translated: $translated, word: $word)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LessonQuizModelImpl &&
            const DeepCollectionEquality().equals(other._options, _options) &&
            (identical(other.translated, translated) ||
                other.translated == translated) &&
            (identical(other.word, word) || other.word == word));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType,
      const DeepCollectionEquality().hash(_options), translated, word);

  /// Create a copy of LessonQuizModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$LessonQuizModelImplCopyWith<_$LessonQuizModelImpl> get copyWith =>
      __$$LessonQuizModelImplCopyWithImpl<_$LessonQuizModelImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$LessonQuizModelImplToJson(
      this,
    );
  }
}

abstract class _LessonQuizModel implements LessonQuizModel {
  const factory _LessonQuizModel(
      {required final List<String> options,
      required final String translated,
      required final String word}) = _$LessonQuizModelImpl;

  factory _LessonQuizModel.fromJson(Map<String, dynamic> json) =
      _$LessonQuizModelImpl.fromJson;

  @override
  List<String> get options;
  @override
  String get translated;
  @override
  String get word;

  /// Create a copy of LessonQuizModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$LessonQuizModelImplCopyWith<_$LessonQuizModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
