import 'package:rxdart/rxdart.dart';

import '../resources/prefs_repository.dart';

class LogInBloc {
  final _repository = PrefsRepository();

  Observable<bool> get isLoggedIn =>
      Observable.fromFuture(_repository.isLoggedIn());

  setLoggedIn() {
    _repository.setLoggedIn();
  }
}

final bloc = LogInBloc();
