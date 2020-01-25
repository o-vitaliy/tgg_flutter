import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:tgg/containers/preview/preview_actions.dart';
import 'package:tgg/containers/preview/preview_middleware.dart';
import 'package:tgg/containers/preview/preview_reducer.dart';
import 'package:tgg/containers/preview/video/video_preview_container.dart';
import 'package:tgg/ui/keys.dart';
import 'package:tgg/ui/pages/navigation_arguments.dart';

import 'preview_image.dart';
import 'preview_state.dart';

const Color defaultBackground = Colors.black38;
const double rowHeight = 48;

class PreviewPage extends StatelessWidget {
  PreviewPage({Key key}) : super(key: Keys.previewPage);
  static const routeName = '/previewImage';

  final store = new Store<PreviewState>(
    previewReducer,
    initialState: PreviewState.initial(),
    middleware: []..addAll(createPreviewStateMiddleware()),
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

class _ViewModel {
  final bool initialized;
  final bool isVideo;

  _ViewModel({this.initialized, this.isVideo});

  static _ViewModel fromStore(Store<PreviewState> store) {
    final state = store.state;
    return _ViewModel(
      initialized: state.initialized,
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
