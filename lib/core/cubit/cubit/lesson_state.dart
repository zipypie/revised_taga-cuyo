part of 'lesson_cubit.dart';

@freezed
class LessonState with _$LessonState {
  const factory LessonState.initial() = _Initial;
  const factory LessonState.loading() = _Loading;
  const factory LessonState.success(List<LessonModel> lessons) = _Success;
  const factory LessonState.successWithCounts(
    List<LessonModel> lessons,
    List<int> counts,
  ) = _SuccessWithCounts;
  const factory LessonState.error(String message) = _Error;
}
