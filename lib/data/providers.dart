import 'package:tgg/data/login_repo.dart';
import 'package:tgg/data/playthrought_repository.dart';
import 'package:tgg/data/providers/api_provider.dart';
import 'package:tgg/data/providers/providers.dart';
import 'package:tgg/data/statics_repo.dart';

ApiProvider apiProvider = ApiProvider();
StaticApiProvider staticApiProvider = StaticApiProvider();
PrefsProvider prefsProvider = PrefsProvider();

// repos
StaticRepo staticRepo = StaticRepo(apiProvider: staticApiProvider);
LoginRepo loginRepo = LoginRepo(apiProvider: apiProvider, prefs: prefsProvider);
PlaythroughRepo playthroughRepo =
    PlaythroughRepo(apiProvider: apiProvider, staticRepo: staticRepo);
