import 'package:moor/moor.dart';

import 'db.dart';

class DaoMedia {
  final AppDatabase _appDatabase;

  DaoMedia(this._appDatabase);

  Future<int> insert(String mediaId, String fileUrl, String key) {
    return _appDatabase.intoMediaTable.insert(
        MediaTableCompanion.insert(
          mediaId: mediaId,
          fileUrl: fileUrl,
          key: key,
          uploaded: false,
        ),
        mode: InsertMode.insertOrAbort);
  }

  Future<MediaTableData> findByKey(String key) {
    return (_appDatabase.selectMediaTable
          ..where((t) => t.key.equals(key))
          ..orderBy(
              [(u) => OrderingTerm(expression: u.id, mode: OrderingMode.desc)])
          ..limit(1))
        .getSingle();
  }

  Future<MediaTableData> findByUrl(String url) {
    return (_appDatabase.selectMediaTable..where((t) => t.fileUrl.equals(url)))
        .getSingle();
  }

  Future<int> updateUploadedByUrl(String url, bool uploaded) {
    return (_appDatabase.updateMediaTable..where((t) => t.fileUrl.equals(url)))
        .write(MediaTableCompanion(uploaded: Value(true)));
  }
}
