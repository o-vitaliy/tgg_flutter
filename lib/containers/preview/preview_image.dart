import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:tgg/containers/preview/preview_actions.dart';
import 'package:tgg/ui/pages/preview/preview.dart';
import 'package:tgg/ui/widgets/text_button.dart';

import 'preview_state.dart';

class ImagePreview extends StatelessWidget {
  const ImagePreview({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreConnector<PreviewState, _ViewModel>(
        converter: _ViewModel.fromStore,
        distinct: true,
        builder: (BuildContext context, _ViewModel vm) {
          return Stack(
            children: <Widget>[
              Center(child: Image.file(File(vm.url))),
              buildPreviewControls(vm)
            ],
          );
        });
  }

  Widget buildPreviewControls(_ViewModel vm) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: SizedBox.fromSize(
          size: Size.fromHeight(rowHeight),
          child: Stack(
            fit: StackFit.passthrough,
            children: <Widget>[
              Container(
                height: 48,
                color: defaultBackground,
              ),
              Align(
                  alignment: Alignment.centerLeft,
                  child: TextButton(
                    text: "Back",
                    onTap: vm.retake,
                  )),
              Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    text: "Submit",
                    onTap: vm.submit,
                  )),
            ],
          )),
    );
  }
}

class _ViewModel {
  final String url;
  final Function(BuildContext context) retake;
  final Function(BuildContext context) submit;


  _ViewModel({this.url, this.retake, this.submit, });

  static _ViewModel fromStore(Store<PreviewState> store) {
    final state = store.state;
    return _ViewModel(
      url: state.preview,
      retake: (BuildContext context) =>
          store.dispatch(RetakePreviewAction(context)),
      submit: (BuildContext context) =>
          store.dispatch(SubmitPreviewAction(context)),
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is _ViewModel &&
          runtimeType == other.runtimeType &&
          url == other.url;

  @override
  int get hashCode => url.hashCode;
}
