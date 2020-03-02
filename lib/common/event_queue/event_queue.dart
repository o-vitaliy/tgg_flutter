import 'package:flutter/material.dart';
import 'package:tgg/helpers/expandable_list.dart';

class EventQueue {
  final List<_Task> _taskList = List();

  _Task _runningTask;

  void postEvent(VoidCallback action, {int delay = 0, String tag}) {
    if (tag != null) {
      if (_runningTask?.tag == tag) return;
      if (_taskList.firstOrNull((value) => value.tag == tag) != null) return;
    }
    _taskList.add(Event(tag, action));
    if (delay > 0) {
      _taskList.add(_Delay(Duration(milliseconds: delay), tag));
    }
    _checkForTask();
  }

  void _checkForTask() {
    if (_runningTask != null) return;
    if (_taskList.isEmpty) return;
    _runningTask = _taskList.removeAt(0);

    _runningTask.execute().then((value) {
      _runningTask = null;
      _checkForTask();
    });
  }
}

abstract class _Task {
  final String tag;

  _Task(this.tag);

  Future execute();
}

class _Delay extends _Task {
  final Duration duration;

  _Delay(this.duration, String tag) : super(tag);

  @override
  Future execute() => Future.delayed(duration);
}

class Event extends _Task {
  final VoidCallback action;

  Event(String tag, this.action) : super(tag);

  @override
  Future execute() => Future.value({action()});
}

final eventQueue = EventQueue();
