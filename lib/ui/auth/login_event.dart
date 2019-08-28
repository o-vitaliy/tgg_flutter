import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

abstract class LoginEvent extends Equatable {
  LoginEvent([List props = const []]) : super(props);
}

class LoginButtonPressed extends LoginEvent {
  final String code;

  LoginButtonPressed({
    @required this.code,
  }) : super([code]);

  @override
  String toString() => 'LoginButtonPressed { code: $code }';
}
