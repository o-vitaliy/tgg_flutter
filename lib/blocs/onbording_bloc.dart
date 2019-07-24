import '../resources/prefs_repository.dart';
import 'package:rxdart/rxdart.dart';

class OnbordingBloc {
  final _repository = PrefsRepository();

  Observable<bool> get isOnbordingSeen =>
      Observable.fromFuture(_repository.isOnbordingSeen());

  setOnbordingSeen() {
    _repository.setOnbordingSeen();
  }
}

final bloc = OnbordingBloc();
