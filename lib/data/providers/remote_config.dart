import 'package:firebase_remote_config/firebase_remote_config.dart';

class Config {
  RemoteConfig _remoteConfigCache;

  Future<RemoteConfig> get _remoteConfig async {
    if (_remoteConfigCache == null) {
      final config = await RemoteConfig.instance;
      await config.fetch(expiration: const Duration(hours: 5));
      await config.activateFetched();
      _remoteConfigCache = config;
    }
    return _remoteConfigCache;
  }

  Future<String> _getString(String key) =>
      _remoteConfig?.then((v) => v.getString(key));

  Future<String> get awsBucketId => _getString("aws_bucket_id");
  Future<String> get awsSecretAccessKey => _getString("aws_secret_access_key");
  Future<String> get awsAccessKey => _getString("aws_access_key");
}
