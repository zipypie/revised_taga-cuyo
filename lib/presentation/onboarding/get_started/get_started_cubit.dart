import 'package:flutter_bloc/flutter_bloc.dart';

class GetStartedCubit extends Cubit<int> {
  final int totalPages;
  GetStartedCubit(this.totalPages) : super(0);

  void nextPage() {
    if (state < totalPages - 1) {
      emit(state + 1);
    }
  }

  void goToPage(int page) {
    if (page >= 0 && page < totalPages) {
      emit(page);
    }
  }
}
