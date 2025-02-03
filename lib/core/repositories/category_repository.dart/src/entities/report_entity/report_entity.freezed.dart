// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'report_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

ReportEntity _$ReportEntityFromJson(Map<String, dynamic> json) {
  return _ReportEntity.fromJson(json);
}

/// @nodoc
mixin _$ReportEntity {
  String get userId => throw _privateConstructorUsedError;
  @JsonKey(name: 'category_name')
  String get categoryName => throw _privateConstructorUsedError;
  @JsonKey(name: 'subcategory_name')
  String get subcategoryName => throw _privateConstructorUsedError;
  String get reportReason => throw _privateConstructorUsedError;
  @JsonKey(name: 'wordId')
  String get wordId => throw _privateConstructorUsedError;
  @JsonKey(name: 'time_stamp')
  DateTime get timeStamp => throw _privateConstructorUsedError;

  /// Serializes this ReportEntity to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ReportEntity
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ReportEntityCopyWith<ReportEntity> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ReportEntityCopyWith<$Res> {
  factory $ReportEntityCopyWith(
          ReportEntity value, $Res Function(ReportEntity) then) =
      _$ReportEntityCopyWithImpl<$Res, ReportEntity>;
  @useResult
  $Res call(
      {String userId,
      @JsonKey(name: 'category_name') String categoryName,
      @JsonKey(name: 'subcategory_name') String subcategoryName,
      String reportReason,
      @JsonKey(name: 'wordId') String wordId,
      @JsonKey(name: 'time_stamp') DateTime timeStamp});
}

/// @nodoc
class _$ReportEntityCopyWithImpl<$Res, $Val extends ReportEntity>
    implements $ReportEntityCopyWith<$Res> {
  _$ReportEntityCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ReportEntity
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? userId = null,
    Object? categoryName = null,
    Object? subcategoryName = null,
    Object? reportReason = null,
    Object? wordId = null,
    Object? timeStamp = null,
  }) {
    return _then(_value.copyWith(
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      categoryName: null == categoryName
          ? _value.categoryName
          : categoryName // ignore: cast_nullable_to_non_nullable
              as String,
      subcategoryName: null == subcategoryName
          ? _value.subcategoryName
          : subcategoryName // ignore: cast_nullable_to_non_nullable
              as String,
      reportReason: null == reportReason
          ? _value.reportReason
          : reportReason // ignore: cast_nullable_to_non_nullable
              as String,
      wordId: null == wordId
          ? _value.wordId
          : wordId // ignore: cast_nullable_to_non_nullable
              as String,
      timeStamp: null == timeStamp
          ? _value.timeStamp
          : timeStamp // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ReportEntityImplCopyWith<$Res>
    implements $ReportEntityCopyWith<$Res> {
  factory _$$ReportEntityImplCopyWith(
          _$ReportEntityImpl value, $Res Function(_$ReportEntityImpl) then) =
      __$$ReportEntityImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String userId,
      @JsonKey(name: 'category_name') String categoryName,
      @JsonKey(name: 'subcategory_name') String subcategoryName,
      String reportReason,
      @JsonKey(name: 'wordId') String wordId,
      @JsonKey(name: 'time_stamp') DateTime timeStamp});
}

/// @nodoc
class __$$ReportEntityImplCopyWithImpl<$Res>
    extends _$ReportEntityCopyWithImpl<$Res, _$ReportEntityImpl>
    implements _$$ReportEntityImplCopyWith<$Res> {
  __$$ReportEntityImplCopyWithImpl(
      _$ReportEntityImpl _value, $Res Function(_$ReportEntityImpl) _then)
      : super(_value, _then);

  /// Create a copy of ReportEntity
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? userId = null,
    Object? categoryName = null,
    Object? subcategoryName = null,
    Object? reportReason = null,
    Object? wordId = null,
    Object? timeStamp = null,
  }) {
    return _then(_$ReportEntityImpl(
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      categoryName: null == categoryName
          ? _value.categoryName
          : categoryName // ignore: cast_nullable_to_non_nullable
              as String,
      subcategoryName: null == subcategoryName
          ? _value.subcategoryName
          : subcategoryName // ignore: cast_nullable_to_non_nullable
              as String,
      reportReason: null == reportReason
          ? _value.reportReason
          : reportReason // ignore: cast_nullable_to_non_nullable
              as String,
      wordId: null == wordId
          ? _value.wordId
          : wordId // ignore: cast_nullable_to_non_nullable
              as String,
      timeStamp: null == timeStamp
          ? _value.timeStamp
          : timeStamp // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ReportEntityImpl implements _ReportEntity {
  const _$ReportEntityImpl(
      {required this.userId,
      @JsonKey(name: 'category_name') required this.categoryName,
      @JsonKey(name: 'subcategory_name') required this.subcategoryName,
      required this.reportReason,
      @JsonKey(name: 'wordId') required this.wordId,
      @JsonKey(name: 'time_stamp') required this.timeStamp});

  factory _$ReportEntityImpl.fromJson(Map<String, dynamic> json) =>
      _$$ReportEntityImplFromJson(json);

  @override
  final String userId;
  @override
  @JsonKey(name: 'category_name')
  final String categoryName;
  @override
  @JsonKey(name: 'subcategory_name')
  final String subcategoryName;
  @override
  final String reportReason;
  @override
  @JsonKey(name: 'wordId')
  final String wordId;
  @override
  @JsonKey(name: 'time_stamp')
  final DateTime timeStamp;

  @override
  String toString() {
    return 'ReportEntity(userId: $userId, categoryName: $categoryName, subcategoryName: $subcategoryName, reportReason: $reportReason, wordId: $wordId, timeStamp: $timeStamp)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ReportEntityImpl &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.categoryName, categoryName) ||
                other.categoryName == categoryName) &&
            (identical(other.subcategoryName, subcategoryName) ||
                other.subcategoryName == subcategoryName) &&
            (identical(other.reportReason, reportReason) ||
                other.reportReason == reportReason) &&
            (identical(other.wordId, wordId) || other.wordId == wordId) &&
            (identical(other.timeStamp, timeStamp) ||
                other.timeStamp == timeStamp));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, userId, categoryName,
      subcategoryName, reportReason, wordId, timeStamp);

  /// Create a copy of ReportEntity
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ReportEntityImplCopyWith<_$ReportEntityImpl> get copyWith =>
      __$$ReportEntityImplCopyWithImpl<_$ReportEntityImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ReportEntityImplToJson(
      this,
    );
  }
}

abstract class _ReportEntity implements ReportEntity {
  const factory _ReportEntity(
      {required final String userId,
      @JsonKey(name: 'category_name') required final String categoryName,
      @JsonKey(name: 'subcategory_name') required final String subcategoryName,
      required final String reportReason,
      @JsonKey(name: 'wordId') required final String wordId,
      @JsonKey(name: 'time_stamp')
      required final DateTime timeStamp}) = _$ReportEntityImpl;

  factory _ReportEntity.fromJson(Map<String, dynamic> json) =
      _$ReportEntityImpl.fromJson;

  @override
  String get userId;
  @override
  @JsonKey(name: 'category_name')
  String get categoryName;
  @override
  @JsonKey(name: 'subcategory_name')
  String get subcategoryName;
  @override
  String get reportReason;
  @override
  @JsonKey(name: 'wordId')
  String get wordId;
  @override
  @JsonKey(name: 'time_stamp')
  DateTime get timeStamp;

  /// Create a copy of ReportEntity
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ReportEntityImplCopyWith<_$ReportEntityImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
