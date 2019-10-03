import './cluster.dart';

class Sorting {
  List<Cluster> cluster;

  Sorting.fromJsonMap(Map<String, dynamic> map)
      : cluster = List<Cluster>.from(
            map["cluster"].map((it) => Cluster.fromJsonMap(it)));

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['cluster'] =
        cluster != null ? this.cluster.map((v) => v.toJson()).toList() : null;
    return data;
  }
}
