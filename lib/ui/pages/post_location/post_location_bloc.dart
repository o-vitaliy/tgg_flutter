import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:tgg/data/location_repo.dart';

import 'bloc.dart';

const default_delay = Duration(seconds: 20);

class PostLocationBloc extends Bloc<PostLocationEvent, PostLocationState> {
  final LocationRepo locationRepository;

  PostLocationBloc(this.locationRepository);

  @override
  PostLocationState get initialState => StoppedPostLocationState();

  Timer _timer;

  @override
  Stream<PostLocationState> mapEventToState(
    PostLocationEvent event,
  ) async* {
    if (event is StartPostLocationEvent && _timer == null) {
      sendLocation(null);
      _timer = Timer.periodic(default_delay, sendLocation);
    }
    if (event is StopPostLocationEvent) {
      _timer?.cancel();
      _timer = null;
    }
  }

  void sendLocation(Timer timer) async {
    Position position = await Geolocator()
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.lowest);
    await locationRepository.sendLocation(position);
  }
}
