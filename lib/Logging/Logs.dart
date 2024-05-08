class Logs {
  late DateTime startTime;
  static DateTime? switchTime;
  static bool isSwitched = false;

  void startTimer() {
    startTime = DateTime.now();
  }

  static void switchTimer(index) {
    print(index.toString());
    if (index == 1) {
      isSwitched = false;
    } else {
      switchTime = DateTime.now();
      isSwitched = true;
      print("Switch Started");
    }
  }

  int restartTimer() {
    int endTime = DateTime.now().difference(startTime).inSeconds;
    print("Switch Time: $switchTime");
    if (switchTime != null) {
      int switchEndTime = DateTime.now().difference(switchTime!).inSeconds;
      endTime -= switchEndTime;
      switchTime = null;
      print("Switch Time: $switchEndTime");
    }
    startTime = DateTime.now();
    print("TIME");
    return endTime;
  }
}
// init -> start timer -> onPageChanged - stop the timer and start another -> stop the timer start another 