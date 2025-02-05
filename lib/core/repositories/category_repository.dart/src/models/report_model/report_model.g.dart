// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'report_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ReportModelImpl _$$ReportModelImplFromJson(Map<String, dynamic> json) =>
    _$ReportModelImpl(
      userId: json['userId'] as String,
      categoryName: json['categoryName'] as String,
      subcategoryName: json['subcategoryName'] as String,
      reportReason: json['reportReason'] as String,
      wordId: json['wordId'] as String,
      timeStamp: DateTime.parse(json['timeStamp'] as String),
    );

Map<String, dynamic> _$$ReportModelImplToJson(_$ReportModelImpl instance) =>
    <String, dynamic>{
      'userId': instance.userId,
      'categoryName': instance.categoryName,
      'subcategoryName': instance.subcategoryName,
      'reportReason': instance.reportReason,
      'wordId': instance.wordId,
      'timeStamp': instance.timeStamp.toIso8601String(),
    };
