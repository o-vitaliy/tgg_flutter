class Flavor {
  final Map<String, dynamic> values;

  Flavor(this.values);

  String get(String key) => key;

  static Flavor initial() {
    return Flavor(Map<String, dynamic>());
  }
}
