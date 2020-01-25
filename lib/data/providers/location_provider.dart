import 'package:geolocator/geolocator.dart';

class LocationProvider {
  Future<Position> getLocation() async => await Geolocator()
      .getCurrentPosition(desiredAccuracy: LocationAccuracy.lowest);
}
