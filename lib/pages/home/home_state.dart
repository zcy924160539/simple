class HomeState {
  int count = 0;

  HomeState init() {
    return HomeState()..count = count;
  }

  HomeState clone() {
    return HomeState()..count = count;
  }
}
