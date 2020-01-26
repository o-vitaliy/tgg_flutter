import 'package:moor/moor.dart';

import 'db.dart';

class DaoMedia {
  final AppDatabase _appDatabase;

  DaoMedia(this._appDatabase);

  Future<int> insert(String mediaId, String fileUrl, String key) {
    return _appDatabase.into(_appDatabase.mediaTable).insert(
        MediaTableCompanion.insert(
          mediaId: mediaId,
          fileUrl: fileUrl,
          key: key,
          uploaded: false,
        ),
        mode: InsertMode.insertOrAbort);
  }

  Future<MediaTableData> findByKey(String key) {
    return (_appDatabase.select(_appDatabase.mediaTable)
          ..where((t) => t.key.equals(key)))
        .getSingle();
  }

  Future<MediaTableData> findByUrl(String url) {
    return (_appDatabase.select(_appDatabase.mediaTable)
          ..where((t) => t.fileUrl.equals(url)))
        .getSingle();
  }

  Future<int> updateUploadedByUrl(String url, bool uploaded) {
    return (_appDatabase.update(_appDatabase.mediaTable)
          ..where((t) => t.fileUrl.equals(url)))
        .write(MediaTableCompanion(uploaded: Value(true)));
  }
}
