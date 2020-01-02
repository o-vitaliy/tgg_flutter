import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:tgg/bloc/aws_upload/bloc.dart';
import 'package:tgg/redux_model/app_state.dart';
import 'package:tgg/ui/colors.dart';

class UploadContainer extends StatelessWidget {
  final WidgetBuilder widgetBuilder;

  const UploadContainer({Key key, @required this.widgetBuilder})
      : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Column(
      children: <Widget>[_UploadProgress(), widgetBuilder(context)],
    );
  }
}

class _UploadProgress extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, _ViewModel>(
      converter: _ViewModel.fromStore,
      distinct: true,
      builder: (context, vm) {
        if (vm.uploading) {
          return SizedBox.fromSize(
              size: Size.fromHeight(18),
              child: Stack(
                fit: StackFit.expand,
                children: <Widget>[
                  LinearProgressIndicator(
                    value: vm.progress,
                    valueColor: AlwaysStoppedAnimation<Color>(Color(ORANGE)),
                    backgroundColor: Colors.transparent,
                  ),
                  Center(
                    child: Text(
                      "${vm.currentUploading}/${vm.uploadingFilesCount}",
                      style: defaultTextStyle,
                    ),
                  )
                ],
              ));
        } else {
          return SizedBox.shrink();
        }
      },
    );
  }
}

class _ViewModel {
  final int uploadingFilesCount;
  final int currentUploading;
  final double progress;

  _ViewModel({this.uploadingFilesCount, this.currentUploading, this.progress});

  bool get uploading => uploadingFilesCount > 0;

  static _ViewModel fromStore(Store<AppState> store) {
    final state = store.state.uploadFilesState;
    return _ViewModel(
        uploadingFilesCount: state.uploadingFilesCount,
        currentUploading: state.currentUploading,
        progress: state.progress);
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is _ViewModel &&
          runtimeType == other.runtimeType &&
          uploadingFilesCount == other.uploadingFilesCount &&
          currentUploading == other.currentUploading &&
          progress == other.progress;

  @override
  int get hashCode =>
      uploadingFilesCount.hashCode ^
      currentUploading.hashCode ^
      progress.hashCode;
}
