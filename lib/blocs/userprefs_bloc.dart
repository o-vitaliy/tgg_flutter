import 'package:rxdart/rxdart.dart';

import '../resources/prefs_repository.dart';

class UserPreferenceBloc {
  final _repository = PrefsRepository();

  Observable<bool> get isOnbordingSeen =>
      Observable.fromFuture(_repository.isOnbordingSeen());

  setOnbordingSeen() {
    _repository.setOnbordingSeen();
  }

  Observable<bool> get isLoggedIn =>
      Observable.fromFuture(_repository.isLoggedIn());

  setLoggedIn() {
    _repository.setLoggedIn();
  }
}

final bloc = UserPreferenceBloc();
