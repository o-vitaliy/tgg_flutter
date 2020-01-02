import 'package:geolocator/geolocator.dart';
import 'package:tgg/data/login_repo.dart';
import 'package:tgg/data/providers/providers.dart';

class LocationRepo {
  final LoginRepo loginRepo;

  const LocationRepo(this.loginRepo);

  Future sendLocation(Position position) async {
    final login = await logInRepo.getLoginResponse();
    final teamId = login.team.id;
    return apiProvider.location(
        teamId: teamId,
        longitude: position.longitude,
        latitude: position.latitude,
        accuracy: position.accuracy.toInt());
  }
}

final locationRepo = LocationRepo(null);
