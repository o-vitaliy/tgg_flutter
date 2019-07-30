import 'package:rxdart/rxdart.dart';
import 'package:tgg/blocs/validators.dart';
import 'package:tgg/models/game/game_info.dart';
import 'package:tgg/resources/api_repository.dart';

class LoginBloc with Validators {
  final _repository = ApiRepository();

  final _codeController = BehaviorSubject<String>();
  final _gameInfoFetcher = PublishSubject<GameInfo>();

  Function(String) get changeCode => _codeController.sink.add;

  Stream<String> get code =>
      _codeController.stream.transform(gameCodeValidator);

  Stream<bool> get submitValid => Observable(code).map((v) => v.length > 0);

  Stream<bool> get loaded => Observable(_gameInfoFetcher.map((v) => true));

  submit() async {
    final validCode = _codeController.value;
    print('Code is $validCode');
    final gameInfo = await _repository.fetchGameInfo(validCode);
    _gameInfoFetcher.sink.add(gameInfo);
  }

  dispose() {
    _codeController.close();
    _gameInfoFetcher.close();
  }
}
