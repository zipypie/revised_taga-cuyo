import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:taga_cuyo/core/repositories/user_progress_repository/src/entities/time_entity/time_entity.dart';

part 'time_model.freezed.dart';
part 'time_model.g.dart';

@freezed
class TimeModel with _$TimeModel {
  const factory TimeModel({
    required String userId,
    required String date,
  }) = _TimeModel;

  factory TimeModel.fromJson(Map<String, dynamic> json) =>
      _$TimeModelFromJson(json);

  factory TimeModel.fromEntity(TimeEntity entity) {
    return TimeModel(
      userId: entity.userId,
      date: entity.date,
    );
  }
}
