import 'package:meta/meta.dart';
import 'package:rxdart/rxdart.dart';
import 'package:tgg/data/login_repo.dart';
import 'package:tgg/data/providers/location_provider.dart';
import 'package:tgg/data/providers/providers.dart';

class LocationRepo {
  final ApiProvider apiProvider;
  final LoginRepo loginRepo;
  final LocationProvider locationProvider;

  const LocationRepo({
    @required this.apiProvider,
    @required this.loginRepo,
    @required this.locationProvider,
  });

  void sendLocation() async {
    Observable.zip2(
        Observable.fromFuture(locationProvider.getLocation()),
        Observable.fromFuture(loginRepo.getLoginResponse())
            .map((login) => login.team.id),
        (position, teamId) => apiProvider.location(
            teamId: teamId,
            longitude: position.longitude,
            latitude: position.latitude,
            accuracy: position.accuracy.toInt())).listen((r) {
      r.then((_) {});
    });
  }
}
