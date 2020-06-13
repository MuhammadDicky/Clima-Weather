void main() {
  runTasks();
}

void runTasks() {
  task1();
  task2();
  task3();
}

void task1() {
  String test = 'task 1 running...';

  print(test);
}

void task2() async {
  Duration wait3Second = Duration(seconds: 3);
  Future.delayed(wait3Second, () {
    String test = 'task 2 running...';
    print(test);
  });
}

void task3() {
  String test = 'task 3 running...';

  print(test);
}
