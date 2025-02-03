import 'package:freezed_annotation/freezed_annotation.dart';

part 'report_entity.freezed.dart';
part 'report_entity.g.dart';

@freezed
class ReportEntity with _$ReportEntity {
  const factory ReportEntity({
    required String userId,
    @JsonKey(name: 'category_name') required String categoryName,
    @JsonKey(name: 'subcategory_name') required String subcategoryName,
    required String reportReason,
    @JsonKey(name: 'wordId') required String wordId,
    @JsonKey(name: 'time_stamp') required DateTime timeStamp,
  }) = _ReportEntity;

  factory ReportEntity.fromJson(Map<String, dynamic> json) =>
      _$ReportEntityFromJson(json);

  factory ReportEntity.fromFirestore(Map<String, dynamic> data, String id) =>
      ReportEntity.fromJson(data).copyWith();
}
