import 'dart:async';
import 'package:bloc/bloc.dart';
import './bloc.dart';

class PostLocationBloc extends Bloc<PostLocationEvent, PostLocationState> {
  @override
  PostLocationState get initialState => StoppedPostLocationState();

  @override
  Stream<PostLocationState> mapEventToState(
    PostLocationEvent event,
  ) async* {}
}
