import 'package:tgg/data/providers/api_provider.dart';
import 'package:tgg/models/models.dart';

import 'login_repo.dart';

class PlaythroughRepo {
  final LoginRepo loginRepo;

  PlaythroughRepo(this.loginRepo);

  Future<Game> getGame() async {
    return (await getPlaythrough()).game;
  }

  Future<Playthrough> getPlaythrough() async {
    final loginResponse = await loginRepo.getLoginResponse();
    final playthroughId = loginResponse.team.playthroughId;
    final playthrough = await apiProvider.playthroughs(playthroughId);
    return playthrough;
  }
}

final playthroughRepo = PlaythroughRepo(logInRepo);
