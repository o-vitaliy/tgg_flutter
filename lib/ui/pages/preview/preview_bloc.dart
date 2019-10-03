import 'dart:async';
import 'package:bloc/bloc.dart';
import './bloc.dart';

class PreviewBloc extends Bloc<PreviewEvent, PreviewState> {
  @override
  PreviewState get initialState => UnitializedPreviewState();

  @override
  Stream<PreviewState> mapEventToState(
    PreviewEvent event,
  ) async* {
    if (event is InitializePreviewEvent) {
      if (event.args.isVideo) {
        yield VideoPreviewState(event.args.preview);
      } else {
        yield ImagePreviewState(event.args.preview);
      }
    }
  }
}
