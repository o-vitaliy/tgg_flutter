class AddFileToUploadAction {
  final String url;

  AddFileToUploadAction(this.url);
}

class ChangeFileUploadProgressAction {
  final String url;
  final double progress;

  ChangeFileUploadProgressAction(this.url, this.progress);
}
