class AddFileToUploadAction {
  final String url;
  final String key;

  AddFileToUploadAction(this.url, this.key);
}

class ChangeFileUploadProgressAction {
  final String url;
  final double progress;

  ChangeFileUploadProgressAction(this.url, this.progress);
}

class RemoveFileUpload{
  final String url;

  RemoveFileUpload(this.url);
}
