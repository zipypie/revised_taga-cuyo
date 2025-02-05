// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'report_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ReportEntityImpl _$$ReportEntityImplFromJson(Map<String, dynamic> json) =>
    _$ReportEntityImpl(
      userId: json['userId'] as String,
      categoryName: json['categoryName'] as String,
      subcategoryName: json['subcategoryName'] as String,
      reportReason: json['reportReason'] as String,
      wordId: json['wordId'] as String,
      timeStamp: DateTime.parse(json['timeStamp'] as String),
    );

Map<String, dynamic> _$$ReportEntityImplToJson(_$ReportEntityImpl instance) =>
    <String, dynamic>{
      'userId': instance.userId,
      'categoryName': instance.categoryName,
      'subcategoryName': instance.subcategoryName,
      'reportReason': instance.reportReason,
      'wordId': instance.wordId,
      'timeStamp': instance.timeStamp.toIso8601String(),
    };
