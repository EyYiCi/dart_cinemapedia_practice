
import 'package:cinemapedia/domain/datasources/movies_datasource.dart';
import 'package:cinemapedia/domain/entities/movie.dart';
import 'package:cinemapedia/domain/repositories/movies_repositories.dart';

/// <summary>
/// Implementación del repositorio de películas que utiliza un `MoviesDatasource`
/// para obtener los datos de las películas. Esta implementación permite que
/// el origen de los datos se pueda cambiar fácilmente, asegurando flexibilidad.
/// 
/// Cuando se integre con los `Providers` de Riverpod, se inyectará esta implementación
/// para manejar el acceso a los datos.
/// </summary>
class MovieRepositoryImpl extends MoviesRepository {

  // Fuente de datos de las películas que será inyectada en este repositorio
  final MoviesDatasource datasource;

  MovieRepositoryImpl(this.datasource);

  @override
  Future<List<Movie>> getNowPlaying({int page = 1}) {
    
    return datasource.getNowPlaying(page: page);

  }
}



