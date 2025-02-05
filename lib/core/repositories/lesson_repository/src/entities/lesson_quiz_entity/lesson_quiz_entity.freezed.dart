// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'lesson_quiz_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

LessonQuizEntity _$LessonQuizEntityFromJson(Map<String, dynamic> json) {
  return _LessonQuizEntity.fromJson(json);
}

/// @nodoc
mixin _$LessonQuizEntity {
  List<String> get options => throw _privateConstructorUsedError;
  String get translated => throw _privateConstructorUsedError;
  String get word => throw _privateConstructorUsedError;

  /// Serializes this LessonQuizEntity to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of LessonQuizEntity
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $LessonQuizEntityCopyWith<LessonQuizEntity> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $LessonQuizEntityCopyWith<$Res> {
  factory $LessonQuizEntityCopyWith(
          LessonQuizEntity value, $Res Function(LessonQuizEntity) then) =
      _$LessonQuizEntityCopyWithImpl<$Res, LessonQuizEntity>;
  @useResult
  $Res call({List<String> options, String translated, String word});
}

/// @nodoc
class _$LessonQuizEntityCopyWithImpl<$Res, $Val extends LessonQuizEntity>
    implements $LessonQuizEntityCopyWith<$Res> {
  _$LessonQuizEntityCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of LessonQuizEntity
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
abstract class _$$LessonQuizEntityImplCopyWith<$Res>
    implements $LessonQuizEntityCopyWith<$Res> {
  factory _$$LessonQuizEntityImplCopyWith(_$LessonQuizEntityImpl value,
          $Res Function(_$LessonQuizEntityImpl) then) =
      __$$LessonQuizEntityImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({List<String> options, String translated, String word});
}

/// @nodoc
class __$$LessonQuizEntityImplCopyWithImpl<$Res>
    extends _$LessonQuizEntityCopyWithImpl<$Res, _$LessonQuizEntityImpl>
    implements _$$LessonQuizEntityImplCopyWith<$Res> {
  __$$LessonQuizEntityImplCopyWithImpl(_$LessonQuizEntityImpl _value,
      $Res Function(_$LessonQuizEntityImpl) _then)
      : super(_value, _then);

  /// Create a copy of LessonQuizEntity
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? options = null,
    Object? translated = null,
    Object? word = null,
  }) {
    return _then(_$LessonQuizEntityImpl(
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
class _$LessonQuizEntityImpl implements _LessonQuizEntity {
  const _$LessonQuizEntityImpl(
      {required final List<String> options,
      required this.translated,
      required this.word})
      : _options = options;

  factory _$LessonQuizEntityImpl.fromJson(Map<String, dynamic> json) =>
      _$$LessonQuizEntityImplFromJson(json);

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
    return 'LessonQuizEntity(options: $options, translated: $translated, word: $word)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LessonQuizEntityImpl &&
            const DeepCollectionEquality().equals(other._options, _options) &&
            (identical(other.translated, translated) ||
                other.translated == translated) &&
            (identical(other.word, word) || other.word == word));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType,
      const DeepCollectionEquality().hash(_options), translated, word);

  /// Create a copy of LessonQuizEntity
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$LessonQuizEntityImplCopyWith<_$LessonQuizEntityImpl> get copyWith =>
      __$$LessonQuizEntityImplCopyWithImpl<_$LessonQuizEntityImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$LessonQuizEntityImplToJson(
      this,
    );
  }
}

abstract class _LessonQuizEntity implements LessonQuizEntity {
  const factory _LessonQuizEntity(
      {required final List<String> options,
      required final String translated,
      required final String word}) = _$LessonQuizEntityImpl;

  factory _LessonQuizEntity.fromJson(Map<String, dynamic> json) =
      _$LessonQuizEntityImpl.fromJson;

  @override
  List<String> get options;
  @override
  String get translated;
  @override
  String get word;

  /// Create a copy of LessonQuizEntity
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$LessonQuizEntityImplCopyWith<_$LessonQuizEntityImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
