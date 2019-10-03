import 'package:equatable/equatable.dart';

abstract class PostLocationEvent extends Equatable {
  const PostLocationEvent();
}

class StartPostLocationEvent extends PostLocationEvent {
  @override
  List<Object> get props => [];
}

class StopPostLocationEvent extends PostLocationEvent {
  @override
  List<Object> get props => [];
}
