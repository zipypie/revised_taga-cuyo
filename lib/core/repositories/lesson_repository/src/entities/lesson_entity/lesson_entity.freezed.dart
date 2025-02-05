// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'lesson_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

LessonEntity _$LessonEntityFromJson(Map<String, dynamic> json) {
  return _LessonEntity.fromJson(json);
}

/// @nodoc
mixin _$LessonEntity {
  String get lessonName => throw _privateConstructorUsedError;
  String get lessonId => throw _privateConstructorUsedError;
  String get lessonImagePath => throw _privateConstructorUsedError;

  /// Serializes this LessonEntity to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of LessonEntity
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $LessonEntityCopyWith<LessonEntity> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $LessonEntityCopyWith<$Res> {
  factory $LessonEntityCopyWith(
          LessonEntity value, $Res Function(LessonEntity) then) =
      _$LessonEntityCopyWithImpl<$Res, LessonEntity>;
  @useResult
  $Res call({String lessonName, String lessonId, String lessonImagePath});
}

/// @nodoc
class _$LessonEntityCopyWithImpl<$Res, $Val extends LessonEntity>
    implements $LessonEntityCopyWith<$Res> {
  _$LessonEntityCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of LessonEntity
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? lessonName = null,
    Object? lessonId = null,
    Object? lessonImagePath = null,
  }) {
    return _then(_value.copyWith(
      lessonName: null == lessonName
          ? _value.lessonName
          : lessonName // ignore: cast_nullable_to_non_nullable
              as String,
      lessonId: null == lessonId
          ? _value.lessonId
          : lessonId // ignore: cast_nullable_to_non_nullable
              as String,
      lessonImagePath: null == lessonImagePath
          ? _value.lessonImagePath
          : lessonImagePath // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$LessonEntityImplCopyWith<$Res>
    implements $LessonEntityCopyWith<$Res> {
  factory _$$LessonEntityImplCopyWith(
          _$LessonEntityImpl value, $Res Function(_$LessonEntityImpl) then) =
      __$$LessonEntityImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String lessonName, String lessonId, String lessonImagePath});
}

/// @nodoc
class __$$LessonEntityImplCopyWithImpl<$Res>
    extends _$LessonEntityCopyWithImpl<$Res, _$LessonEntityImpl>
    implements _$$LessonEntityImplCopyWith<$Res> {
  __$$LessonEntityImplCopyWithImpl(
      _$LessonEntityImpl _value, $Res Function(_$LessonEntityImpl) _then)
      : super(_value, _then);

  /// Create a copy of LessonEntity
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? lessonName = null,
    Object? lessonId = null,
    Object? lessonImagePath = null,
  }) {
    return _then(_$LessonEntityImpl(
      lessonName: null == lessonName
          ? _value.lessonName
          : lessonName // ignore: cast_nullable_to_non_nullable
              as String,
      lessonId: null == lessonId
          ? _value.lessonId
          : lessonId // ignore: cast_nullable_to_non_nullable
              as String,
      lessonImagePath: null == lessonImagePath
          ? _value.lessonImagePath
          : lessonImagePath // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$LessonEntityImpl implements _LessonEntity {
  const _$LessonEntityImpl(
      {required this.lessonName,
      required this.lessonId,
      required this.lessonImagePath});

  factory _$LessonEntityImpl.fromJson(Map<String, dynamic> json) =>
      _$$LessonEntityImplFromJson(json);

  @override
  final String lessonName;
  @override
  final String lessonId;
  @override
  final String lessonImagePath;

  @override
  String toString() {
    return 'LessonEntity(lessonName: $lessonName, lessonId: $lessonId, lessonImagePath: $lessonImagePath)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LessonEntityImpl &&
            (identical(other.lessonName, lessonName) ||
                other.lessonName == lessonName) &&
            (identical(other.lessonId, lessonId) ||
                other.lessonId == lessonId) &&
            (identical(other.lessonImagePath, lessonImagePath) ||
                other.lessonImagePath == lessonImagePath));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, lessonName, lessonId, lessonImagePath);

  /// Create a copy of LessonEntity
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$LessonEntityImplCopyWith<_$LessonEntityImpl> get copyWith =>
      __$$LessonEntityImplCopyWithImpl<_$LessonEntityImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$LessonEntityImplToJson(
      this,
    );
  }
}

abstract class _LessonEntity implements LessonEntity {
  const factory _LessonEntity(
      {required final String lessonName,
      required final String lessonId,
      required final String lessonImagePath}) = _$LessonEntityImpl;

  factory _LessonEntity.fromJson(Map<String, dynamic> json) =
      _$LessonEntityImpl.fromJson;

  @override
  String get lessonName;
  @override
  String get lessonId;
  @override
  String get lessonImagePath;

  /// Create a copy of LessonEntity
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$LessonEntityImplCopyWith<_$LessonEntityImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
