import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:tgg/ui/keys.dart';
import 'package:tgg/ui/pages/navigation_arguments.dart';

import 'preview_actions.dart';
import 'preview_container_middleware.dart';
import 'preview_image.dart';
import 'preview_reducer.dart';
import 'preview_state.dart';
import 'video/video_preview_container.dart';
import 'video/video_preview_middleware.dart';

const Color defaultBackground = Colors.black38;
const double rowHeight = 48;

class PreviewPage extends StatelessWidget {
  PreviewPage({Key key}) : super(key: Keys.previewPage);
  static const routeName = '/previewImage';

  final store = new Store<PreviewState>(
    previewReducer,
    initialState: PreviewState.initial(),
    middleware: []
      ..addAll(createPreviewContainerMiddleware())
      ..addAll(createVideoPreviewMiddleware()),
  );

  @override
  Widget build(BuildContext context) {
    return new StoreProvider(
      store: store,
      child: PreviewContainer(),
    );
  }
}

class PreviewContainer extends StatelessWidget {
  PreviewContainer({Key key}) : super(key: Keys.previewPage);

  @override
  Widget build(BuildContext context) {
    ImagePreviewArguments args = ModalRoute.of(context).settings.arguments;

    return Scaffold(
        backgroundColor: Colors.black,
        body: SafeArea(
            child: StoreConnector<PreviewState, _ViewModel>(
                converter: _ViewModel.fromStore,
                distinct: true,
                onInit: (store) {
                  store.dispatch(InitPreviewAction(args));
                },
                builder: (BuildContext context, _ViewModel vm) {
                  return buildPreview(vm);
                })));
  }

  Widget buildPreview(_ViewModel vm) {
    if (vm.initialized) {
      if (!vm.isVideo)
        return ImagePreview(
          key: Keys.previewImagePage,
        );
      else
        return VideoPreviewContainer(
          key: Keys.previewVideoPage,
        );
    }

    return Container();
  }
}

@immutable
class _ViewModel {
  final bool initialized;
  final bool isVideo;

  _ViewModel({@required this.initialized, @required this.isVideo});

  static _ViewModel fromStore(Store<PreviewState> store) {
    final state = store.state.containerState;
    return _ViewModel(
      initialized: state.initialized,
      isVideo: state.isVideo,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is _ViewModel &&
          runtimeType == other.runtimeType &&
          initialized == other.initialized &&
          isVideo == other.isVideo;

  @override
  int get hashCode => initialized.hashCode ^ isVideo.hashCode;
}
