import 'package:tgg/models/blueprint_model.dart';
import 'package:tgg/resources/static_data_repository.dart';
import 'package:rxdart/rxdart.dart';

class BlueprintBloc {
  final _repository = StaticDataRepository();
  final _blueprintFetcher = PublishSubject<BlueprintModel>();

  Observable<BlueprintModel> get blueprint => _blueprintFetcher.stream;

  fetchBlueprint() async {
    BlueprintModel itemModel = await _repository.fetchBlueprint();
    _blueprintFetcher.sink.add(itemModel);
  }

  dispose() {
    _blueprintFetcher.close();
  }
}

final bloc = BlueprintBloc();
