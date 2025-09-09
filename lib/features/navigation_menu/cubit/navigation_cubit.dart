import 'package:flutter_bloc/flutter_bloc.dart';

class NavigationCubit extends Cubit<int> {
  NavigationCubit() : super(0);

  final List<int> _navigationHistory = [0];

  int get currentIndex => state;

  List<int> get history => List.unmodifiable(_navigationHistory);

  bool canPop() => _navigationHistory.length > 1;

  void changeTab(int index) {
    if (state == index) return;
    _navigationHistory.add(index);
    emit(index);
  }

  void popTab() {
    if (_navigationHistory.length > 1) {
      _navigationHistory.removeLast();
      emit(_navigationHistory.last);
    }
  }

  void goHome() {
    _navigationHistory.clear();
    _navigationHistory.add(0);
    emit(0);
  }
}
