import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/navigation/navigation_cubit.dart';
import '../widgets/native_tab_bar/fallback_tab_bar.dart';
import '../widgets/native_tab_bar/native_tab_bar.dart';
import '../widgets/native_tab_bar/native_tab_bar_controller.dart';
import 'home/home_screen.dart';
import 'profile/profile_screen.dart';
import 'search/search_screen.dart';
import 'stats/stats_screen.dart';

// MARK: - MainShell

final class MainShell extends StatefulWidget {
  const MainShell({super.key});

  @override
  State<MainShell> createState() => _MainShellState();
}

class _MainShellState extends State<MainShell> {
  // GlobalKey guarantees NativeTabBar is instantiated ONCE and never recreated,
  // even if this State's build() runs again.
  final _tabBarKey = GlobalKey();
  NativeTabBarController? _controller;

  void _onControllerCreated(NativeTabBarController controller) {
    _controller = controller;
    // Sync native bar to whatever tab the Cubit already holds on first init.
    final initialIndex = context.read<NavigationCubit>().state.selectedIndex;
    if (initialIndex != 0) {
      controller.setSelectedIndex(initialIndex);
    }
  }

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<NavigationCubit>();

    return Scaffold(
      extendBody: true,
      // BlocListener drives native tab bar index from Cubit state.
      // listenWhen filters out reselect events (native already shows correct tab).
      body: BlocListener<NavigationCubit, NavigationState>(
        listenWhen: (prev, curr) =>
            !curr.isReselected && prev.selectedIndex != curr.selectedIndex,
        listener: (_, state) {
          _controller?.setSelectedIndex(state.selectedIndex);
        },
        child: BlocBuilder<NavigationCubit, NavigationState>(
          buildWhen: (prev, curr) => prev.selectedIndex != curr.selectedIndex,
          builder: (_, state) => IndexedStack(
            index: state.selectedIndex,
            children: const [
              HomeScreen(),
              SearchScreen(),
              StatsScreen(),
              ProfileScreen(),
            ],
          ),
        ),
      ),
      bottomNavigationBar: (!kIsWeb && Platform.isIOS)
          ? NativeTabBar(
              key: _tabBarKey,
              onControllerCreated: _onControllerCreated,
              onTabSelected: cubit.tabSelected,
            )
          : BlocBuilder<NavigationCubit, NavigationState>(
              buildWhen: (prev, curr) =>
                  prev.selectedIndex != curr.selectedIndex,
              builder: (_, state) => FallbackTabBar(
                selectedIndex: state.selectedIndex,
                onTabSelected: cubit.tabSelected,
              ),
            ),
    );
  }
}

