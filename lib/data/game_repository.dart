import 'package:tgg/models/models.dart';

import 'login_repo.dart';

class GameRepo {
  final LoginRepo loginRepo;

  GameRepo(this.loginRepo);

  Future<Game> getGame() async {
    return (await loginRepo.getLoginResponse())?.team?.playthrough?.game;
  }
}
