// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'report_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ReportEntityImpl _$$ReportEntityImplFromJson(Map<String, dynamic> json) =>
    _$ReportEntityImpl(
      userId: json['userId'] as String,
      categoryName: json['category_name'] as String,
      subcategoryName: json['subcategory_name'] as String,
      reportReason: json['reportReason'] as String,
      wordId: json['wordId'] as String,
      timeStamp: DateTime.parse(json['time_stamp'] as String),
    );

Map<String, dynamic> _$$ReportEntityImplToJson(_$ReportEntityImpl instance) =>
    <String, dynamic>{
      'userId': instance.userId,
      'category_name': instance.categoryName,
      'subcategory_name': instance.subcategoryName,
      'reportReason': instance.reportReason,
      'wordId': instance.wordId,
      'time_stamp': instance.timeStamp.toIso8601String(),
    };
