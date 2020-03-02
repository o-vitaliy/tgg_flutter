import 'package:flutter_test/flutter_test.dart';
import 'package:tgg/common/event_queue/event_queue.dart';

main() {
  group("event queue", () {
    test("check all tasks are done", () async {
      bool task1Done;
      bool task2Done;

      final EventQueue eventQueue = EventQueue();
      eventQueue.postEvent(() {
        task1Done = true;
      });

      eventQueue.postEvent(() {
        task2Done = true;
      });

      await Future.delayed(Duration(milliseconds: 1));

      expect(task1Done, true);
      expect(task2Done, true);
    });

    test("check last skiped because of delay", () async {
      bool task1Done;
      bool task2Done;
      final EventQueue eventQueue = EventQueue();
      eventQueue.postEvent(() {
        task1Done = true;
      }, delay: 10);

      eventQueue.postEvent(() {
        task2Done = true;
      });

      await Future.delayed(Duration(milliseconds: 9));

      expect(task1Done, true);
      expect(task2Done, null);
    });

    test("check last skiped because of same tag", () async {
      bool task1Done;
      bool task2Done;
      bool task3Done;

      final EventQueue eventQueue = EventQueue();
      eventQueue.postEvent(() {
        task1Done = true;
      });

      eventQueue.postEvent(() {
        task2Done = true;
      }, tag: "task");

      eventQueue.postEvent(() {
        task3Done = true;
      }, tag: "task");

      await Future.delayed(Duration(milliseconds: 5));

      expect(task1Done, true);
      expect(task2Done, true);
      expect(task3Done, null);
    });
    test("check last skiped because of same tag in delay", () async {
      bool task1Done;
      bool task2Done;

      final EventQueue eventQueue = EventQueue();
      eventQueue.postEvent(() {
        task1Done = true;
      }, delay: 10, tag: "task");
      await Future.delayed(Duration(milliseconds: 5));
      eventQueue.postEvent(() {
        task2Done = true;
      }, tag: "task");

      await Future.delayed(Duration(milliseconds: 12));

      expect(task1Done, true);
      expect(task2Done, null);
    });

    test("check dealy between events", () async {
      DateTime task1Done;
      DateTime task2Done;
      final EventQueue eventQueue = EventQueue();
      eventQueue.postEvent(() {
        task1Done = DateTime.now();
      }, delay: 1000);

      eventQueue.postEvent(() {
        task2Done = DateTime.now();
      });

      await Future.delayed(Duration(seconds: 1, milliseconds: 100));
      expect(task2Done.difference(task1Done).inSeconds, 1);
    });
  });
}
