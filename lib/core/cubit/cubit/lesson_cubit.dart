import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:taga_cuyo/core/repositories/lesson_repository/src/firestore_lesson_repository.dart';
import 'package:taga_cuyo/core/repositories/lesson_repository/src/models/lesson_model/lesson_model.dart';

part 'lesson_state.dart';
part 'lesson_cubit.freezed.dart';

class LessonCubit extends Cubit<LessonState> {
  final FirebaseLessonRepository _lessonRepository;

  LessonCubit(this._lessonRepository) : super(const LessonState.initial());

  Future<void> getLessonWithCounts() async {
    try {
      emit(const LessonState.loading());
      final lessons = await _lessonRepository.getLesson();
      final counts = await Future.wait(
        lessons.map(
            (lesson) => _lessonRepository.getLessonQuizCount(lesson.lessonId)),
      );
      emit(LessonState.successWithCounts(lessons, counts));
    } catch (e) {
      emit(LessonState.error(e.toString()));
    }
  }
}
