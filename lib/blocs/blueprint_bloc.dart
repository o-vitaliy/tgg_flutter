import 'package:rxdart/rxdart.dart';
import 'package:tgg/models/blueprint_model.dart';
import 'package:tgg/models/routing.dart';
import 'package:tgg/resources/static_data_repository.dart';

class BlueprintBloc {
  final _repository = StaticDataRepository();
  final _blueprintFetcher = BehaviorSubject<BlueprintModel>();

  Observable<BlueprintModel> get blueprint => _blueprintFetcher;

  Observable<Routing> get routing =>
      _blueprintFetcher.map((b) => b.routing);

  fetchBlueprint() async {
    BlueprintModel itemModel = await _repository.fetchBlueprint();
    _blueprintFetcher.sink.add(itemModel);
  }

  dispose() {
    _blueprintFetcher.close();
  }
}

final bloc = BlueprintBloc();
