import 'package:meta/meta.dart';

@immutable
class AwsUploadState {
  final Iterable<_UploadingFile> files;

  Iterable<_UploadingFile> get _uploadingFiles =>
      files.where((f) => f.progress < 1);

  int get uploadingFilesCount => _uploadingFiles.length;

  double get progress =>
      sum(_uploadingFiles.map((f) => f.progress)) /
      (uploadingFilesCount.toDouble());

  int get currentUploading =>
      _uploadingFiles.toList().indexWhere((f) => f.progress > 0.0);

  AwsUploadState(this.files);

  AwsUploadState updateProgress({
    @required String url,
    @required double progress,
  }) {
    List<_UploadingFile> files =
        _uploadingFiles.where((f) => f.url != url).toList();
    files.add(_UploadingFile(url, progress));
    return AwsUploadState(files);
  }

  AwsUploadState remove({@required String url}) {
    List<_UploadingFile> files =
        _uploadingFiles.where((f) => f.url != url).toList();
    return AwsUploadState(files);
  }

  factory AwsUploadState.initial() {
    return AwsUploadState(List());
  }
}

class _UploadingFile {
  final String url;
  final double progress;

  _UploadingFile(this.url, this.progress);

  _UploadingFile updateProgress(double progress) =>
      _UploadingFile(url, progress);

  factory _UploadingFile.initial(String url) => _UploadingFile(url, 0);
}

double sum(Iterable<double> values, {double defValue = 0}) {
  if (values.length == 0)
    return defValue;
  else
    return values.reduce((v, e) => v + e);
}
