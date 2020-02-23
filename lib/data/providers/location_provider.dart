import 'package:geolocator/geolocator.dart';

class LocationProvider {
  Future<Position> getLocation() async => await Geolocator()
      .getCurrentPosition(desiredAccuracy: LocationAccuracy.lowest);

  Map toFix(Position location) {
    return {
      "time": DateTime.now().toIso8601String(),
      "coords": [
        location.latitude,
        location.longitude,
      ],
      "accuracy": location.accuracy.toInt()
    };
  }
}
