// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'time_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

TimeEntity _$TimeEntityFromJson(Map<String, dynamic> json) {
  return _TimeEntity.fromJson(json);
}

/// @nodoc
mixin _$TimeEntity {
  String get userId => throw _privateConstructorUsedError;
  String get date => throw _privateConstructorUsedError;

  /// Serializes this TimeEntity to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of TimeEntity
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $TimeEntityCopyWith<TimeEntity> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TimeEntityCopyWith<$Res> {
  factory $TimeEntityCopyWith(
          TimeEntity value, $Res Function(TimeEntity) then) =
      _$TimeEntityCopyWithImpl<$Res, TimeEntity>;
  @useResult
  $Res call({String userId, String date});
}

/// @nodoc
class _$TimeEntityCopyWithImpl<$Res, $Val extends TimeEntity>
    implements $TimeEntityCopyWith<$Res> {
  _$TimeEntityCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of TimeEntity
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? userId = null,
    Object? date = null,
  }) {
    return _then(_value.copyWith(
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      date: null == date
          ? _value.date
          : date // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$TimeEntityImplCopyWith<$Res>
    implements $TimeEntityCopyWith<$Res> {
  factory _$$TimeEntityImplCopyWith(
          _$TimeEntityImpl value, $Res Function(_$TimeEntityImpl) then) =
      __$$TimeEntityImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String userId, String date});
}

/// @nodoc
class __$$TimeEntityImplCopyWithImpl<$Res>
    extends _$TimeEntityCopyWithImpl<$Res, _$TimeEntityImpl>
    implements _$$TimeEntityImplCopyWith<$Res> {
  __$$TimeEntityImplCopyWithImpl(
      _$TimeEntityImpl _value, $Res Function(_$TimeEntityImpl) _then)
      : super(_value, _then);

  /// Create a copy of TimeEntity
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? userId = null,
    Object? date = null,
  }) {
    return _then(_$TimeEntityImpl(
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      date: null == date
          ? _value.date
          : date // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$TimeEntityImpl implements _TimeEntity {
  const _$TimeEntityImpl({required this.userId, required this.date});

  factory _$TimeEntityImpl.fromJson(Map<String, dynamic> json) =>
      _$$TimeEntityImplFromJson(json);

  @override
  final String userId;
  @override
  final String date;

  @override
  String toString() {
    return 'TimeEntity(userId: $userId, date: $date)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TimeEntityImpl &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.date, date) || other.date == date));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, userId, date);

  /// Create a copy of TimeEntity
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$TimeEntityImplCopyWith<_$TimeEntityImpl> get copyWith =>
      __$$TimeEntityImplCopyWithImpl<_$TimeEntityImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$TimeEntityImplToJson(
      this,
    );
  }
}

abstract class _TimeEntity implements TimeEntity {
  const factory _TimeEntity(
      {required final String userId,
      required final String date}) = _$TimeEntityImpl;

  factory _TimeEntity.fromJson(Map<String, dynamic> json) =
      _$TimeEntityImpl.fromJson;

  @override
  String get userId;
  @override
  String get date;

  /// Create a copy of TimeEntity
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$TimeEntityImplCopyWith<_$TimeEntityImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
