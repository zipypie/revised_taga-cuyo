import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'report_entity.freezed.dart';
part 'report_entity.g.dart';

@freezed
class ReportEntity with _$ReportEntity {
  const factory ReportEntity({
    required String userId,
    required String categoryName,
    required String subcategoryName,
    required String reportReason,
    required String wordId,
    required DateTime timeStamp,
  }) = _ReportEntity;

  factory ReportEntity.fromJson(Map<String, dynamic> json) =>
      _$ReportEntityFromJson(json);

  factory ReportEntity.fromFirestore(Map<String, dynamic> data, String id) {
    // Create the ReportEntity from Firestore data
    return ReportEntity(
      userId: data['userId'] as String,
      categoryName: data['category_name'] as String,
      subcategoryName: data['subcategory_name'] as String,
      reportReason: data['reportReason'] as String,
      wordId: data['wordId'] as String,
      timeStamp: (data['time_stamp'] as Timestamp)
          .toDate(), // Convert Firestore Timestamp to DateTime
    );
  }
}
