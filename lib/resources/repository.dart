import 'dart:async';

import '../models/item_model.dart';
import '../models/trailer_model.dart';
import 'api_provider.dart';

class Repository {
  final moviesApiProvider = ApiProvider();

  Future<ItemModel> fetchAllMovies() => moviesApiProvider.fetchMovieList();

  Future<TrailerModel> fetchTrailers(int movieId) =>
      moviesApiProvider.fetchTrailer(movieId);
}
