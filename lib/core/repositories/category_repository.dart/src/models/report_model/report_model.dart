import 'package:freezed_annotation/freezed_annotation.dart';
import '../../entities/report_entity/report_entity.dart';

part 'report_model.freezed.dart';
part 'report_model.g.dart';

@freezed
class ReportModel with _$ReportModel {
  const factory ReportModel({
    required String userId,
    @JsonKey(name: 'category_name') required String categoryName,
    @JsonKey(name: 'subcategory_name') required String subcategoryName,
    required String reportReason,
    @JsonKey(name: 'wordId') required String wordId,
    @JsonKey(name: 'time_stamp') required DateTime timeStamp,
  }) = _ReportModel;

  factory ReportModel.fromJson(Map<String, dynamic> json) =>
      _$ReportModelFromJson(json);

  factory ReportModel.fromEntity(ReportEntity entity) {
    return ReportModel(
      userId: entity.userId,
      categoryName: entity.categoryName,
      subcategoryName: entity.subcategoryName,
      wordId: entity.wordId,
      reportReason: entity.reportReason,
      timeStamp: entity.timeStamp,
    );
  }
}
