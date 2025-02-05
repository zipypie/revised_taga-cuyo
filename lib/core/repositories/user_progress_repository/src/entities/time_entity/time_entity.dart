import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'time_entity.freezed.dart';
part 'time_entity.g.dart';

@freezed
class TimeEntity with _$TimeEntity {
  const factory TimeEntity({
    required String userId,
    required String date,
  }) = _TimeEntity;

  factory TimeEntity.fromJson(Map<String, dynamic> json) =>
      _$TimeEntityFromJson(json);

  factory TimeEntity.fromSnapshopt(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>? ?? {};
    return TimeEntity(
      userId: doc.id,
      date: data['date'] ?? '',
    );
  }
}
