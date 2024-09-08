import 'package:cinemapedia/infrastructure/datasources/moviedb_datasource.dart';
import 'package:cinemapedia/infrastructure/repositories/movie_repository_impl.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Este repositorio es inmutable, por lo que se puede declarar como final.
final movieRepositoryPrivider = Provider((ref) {
  return MovieRepositoryImpl((MoviedbDatasource()));
});
