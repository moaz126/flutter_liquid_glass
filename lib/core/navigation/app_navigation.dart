enum AppTab {
  home,
  search,
  stats,
  profile;

  static AppTab fromIndex(int index) {
    assert(index >= 0 && index < AppTab.values.length, 'Index out of range');
    return AppTab.values[index];
  }
}

abstract final class AppRoutes {
  static const home = '/';
  static const search = '/search';
  static const stats = '/stats';
  static const profile = '/profile';
}
