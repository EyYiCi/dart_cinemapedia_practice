import 'package:cinemapedia/domain/entities/movie.dart'; // Importa la entidad Movie desde el dominio de la aplicación.
import 'package:cinemapedia/presentation/providers/movies/movies_repository_provider.dart'; // Importa el proveedor del repositorio de películas desde la capa de presentación.
import 'package:flutter_riverpod/flutter_riverpod.dart'; // Importa Riverpod, una biblioteca para el manejo del estado en Flutter.

// Define un proveedor de estado para gestionar una lista de películas que se están reproduciendo actualmente (now playing).
// Este proveedor es un StateNotifierProvider que notifica cambios de estado y contiene una lista de objetos Movie.
final nowPlayingMoviesProvider =
    StateNotifierProvider<MoviesNotifier, List<Movie>>((ref) {
  // Obtiene la función fetchMoreMovies del repositorio de películas (movieRepositoryProvider)
  // usando el contexto de referencia (ref) para observar el repositorio y obtener las películas que están en cartelera.
  final fetchMoreMovies = ref.watch(movieRepositoryPrivider).getNowPlaying;

  // Retorna una instancia de MoviesNotifier, pasándole la función fetchMoreMovies
  // que se encargará de obtener las próximas páginas de películas.
  return MoviesNotifier(fetchMoreMovies: fetchMoreMovies);
});

// Define un alias (typedef) para una función llamada MovieCallback.
// Esta función debe devolver un Future que eventualmente contendrá una lista de objetos Movie.
// Además, acepta un parámetro opcional con nombre, `int page`, que especifica el número de la página que se quiere cargar.
typedef MovieCallback = Future<List<Movie>> Function({int page});

// Define la clase MoviesNotifier, que extiende de StateNotifier con un estado que es una lista de objetos Movie.
class MoviesNotifier extends StateNotifier<List<Movie>> {
  // Propiedad que mantiene un contador de la página actual que se está cargando.
  int currentPage = 0;

  // Una propiedad de tipo MovieCallback, que es una referencia a la función que se encargará de obtener más películas.
  MovieCallback fetchMoreMovies;

  // Constructor de la clase, que inicializa la propiedad fetchMoreMovies y llama al constructor
  // de la clase padre (StateNotifier) con una lista vacía como estado inicial.
  MoviesNotifier({
    required this.fetchMoreMovies, // Parámetro requerido para obtener más películas.
  }) : super([]); // El estado inicial es una lista vacía.

  // Método asincrónico que se encarga de cargar la siguiente página de películas.
  Future<void> loadNextPage() async {
    currentPage++; // Incrementa el número de la página que se va a cargar.

    // Llama a fetchMoreMovies para obtener la lista de películas de la página actual.
    // La función espera hasta que se obtenga la lista y la asigna a la variable `movies`.
    final List<Movie> movies = await fetchMoreMovies(page: currentPage);

    // Actualiza el estado actual agregando las nuevas películas a la lista ya existente.
    // Usa el operador de propagación para combinar las listas.
    state = [...state, ...movies];
  }
}
