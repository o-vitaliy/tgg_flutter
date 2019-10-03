import 'package:equatable/equatable.dart';

abstract class PostLocationState extends Equatable {
  const PostLocationState();
}

class StoppedPostLocationState extends PostLocationState {
  @override
  List<Object> get props => [];
}

class RunningPostLocationState extends PostLocationState {
  @override
  List<Object> get props => [];
}
