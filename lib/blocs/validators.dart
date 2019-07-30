import 'dart:async';

class Validators {
  final gameCodeValidator =
  StreamTransformer<String, String>.fromHandlers(handleData: (code, sink) {
    if (code.length > 0) {
      sink.add(code);
    } else {
      sink.addError('Enter a valid email');
    }
  });
}
