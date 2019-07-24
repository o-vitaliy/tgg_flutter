import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' show Client;

import '../models/item_model.dart';
import '../models/trailer_model.dart';

class ApiProvider {
  Client client = Client();
  final _baseUrl = 'https://test-play.thegogame.com/api/';

  Future<ItemModel> fetchMovieList() async {
    print("entered");
    final response =
        await client.get("$_baseUrl/movie/popular?api_key=");
    print(response.body.toString());
    if (response.statusCode == 200) {
      // If the call to the server was successful, parse the JSON
      return ItemModel.fromJson(json.decode(response.body));
    } else {
      // If that call was not successful, throw an error.
      throw Exception('Failed to load post');
    }
  }

  Future<TrailerModel> fetchTrailer(int movieId) async {
    final url = "$_baseUrl/movie/$movieId/videos?api_key=";
    final response = await client.get(url);

    if (response.statusCode == 200) {
      return TrailerModel.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load trailers');
    }
  }
}
