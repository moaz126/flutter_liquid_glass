import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_liquid_glass/core/navigation/navigation_cubit.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('NavigationCubit', () {
    late NavigationCubit cubit;

    setUp(() => cubit = NavigationCubit());
    tearDown(() => cubit.close());

    test(
      'initial state has selectedIndex 0, previousIndex 0, isReselected false',
      () {
        expect(
          cubit.state,
          const NavigationState(selectedIndex: 0, previousIndex: 0),
        );
        expect(cubit.state.isReselected, isFalse);
      },
    );

    blocTest<NavigationCubit, NavigationState>(
      'tabSelected emits correct state with updated selectedIndex',
      build: NavigationCubit.new,
      act: (c) => c.tabSelected(2),
      expect: () => [const NavigationState(selectedIndex: 2, previousIndex: 0)],
    );

    blocTest<NavigationCubit, NavigationState>(
      'tabSelected on same index emits reselected state',
      build: NavigationCubit.new,
      seed: () => const NavigationState(selectedIndex: 1, previousIndex: 0),
      act: (c) => c.tabSelected(1),
      expect: () => [
        const NavigationState(
          selectedIndex: 1,
          previousIndex: 1,
          isReselected: true,
        ),
      ],
    );

    blocTest<NavigationCubit, NavigationState>(
      'previousIndex is tracked correctly across multiple tab changes',
      build: NavigationCubit.new,
      act: (c) {
        c.tabSelected(1);
        c.tabSelected(3);
      },
      expect: () => [
        const NavigationState(selectedIndex: 1, previousIndex: 0),
        const NavigationState(selectedIndex: 3, previousIndex: 1),
      ],
    );

    blocTest<NavigationCubit, NavigationState>(
      'tabReselected directly emits reselected state',
      build: NavigationCubit.new,
      seed: () => const NavigationState(selectedIndex: 2, previousIndex: 0),
      act: (c) => c.tabReselected(2),
      expect: () => [
        const NavigationState(
          selectedIndex: 2,
          previousIndex: 2,
          isReselected: true,
        ),
      ],
    );

    blocTest<NavigationCubit, NavigationState>(
      'isReselected is false on normal tab change after a reselect',
      build: NavigationCubit.new,
      seed: () => const NavigationState(
        selectedIndex: 2,
        previousIndex: 2,
        isReselected: true,
      ),
      act: (c) => c.tabSelected(0),
      expect: () => [const NavigationState(selectedIndex: 0, previousIndex: 2)],
    );
  });
}
