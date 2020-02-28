class FlavorLoadDefaultAction {}

class FlavorLoadAction{
  final String blueprintId;
  final String gameId;

  FlavorLoadAction(this.blueprintId, this.gameId);
}

class FlavorSaveAction {
  final Map<String, dynamic> flavor;

  FlavorSaveAction(this.flavor);
}
