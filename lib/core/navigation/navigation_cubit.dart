import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// MARK: - State

final class NavigationState extends Equatable {
  const NavigationState({
    required this.selectedIndex,
    required this.previousIndex,
    this.isReselected = false,
  });

  final int selectedIndex;
  final int previousIndex;
  final bool isReselected;

  @override
  List<Object> get props => [selectedIndex, previousIndex, isReselected];
}

// MARK: - Cubit

final class NavigationCubit extends Cubit<NavigationState> {
  NavigationCubit()
    : super(const NavigationState(selectedIndex: 0, previousIndex: 0));

  void tabSelected(int index) {
    if (index == state.selectedIndex) {
      tabReselected(index);
      return;
    }
    emit(
      NavigationState(selectedIndex: index, previousIndex: state.selectedIndex),
    );
  }

  void tabReselected(int index) {
    emit(
      NavigationState(
        selectedIndex: index,
        previousIndex: state.selectedIndex,
        isReselected: true,
      ),
    );
  }
}
