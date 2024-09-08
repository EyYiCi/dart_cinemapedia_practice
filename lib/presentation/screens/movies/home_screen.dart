// Importaciones necesarias para usar Flutter y Riverpod
import 'package:cinemapedia/presentation/providers/movies/movies_providers.dart'; // Proveedor de películas (para manejo del estado)
import 'package:flutter/material.dart'; // Importa la biblioteca básica de Flutter para crear interfaces de usuario
import 'package:flutter_riverpod/flutter_riverpod.dart'; // Importa Riverpod, para el manejo de estado reactivo

// Define una clase `HomeScreen` que es una pantalla principal de la aplicación.
class HomeScreen extends StatelessWidget {
  // Nombre estático para la ruta de la pantalla, útil para navegación.
  static const name = 'home-screen';

  // Constructor de la clase `HomeScreen`
  const HomeScreen({super.key});

  // Método `build` que construye la interfaz de la pantalla.
  // En este caso, devuelve un `Scaffold` con un cuerpo que contiene el widget `_HomeView`.
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
        body:
            _HomeView()); // `Scaffold` es la estructura básica para crear la pantalla, y `_HomeView` es el widget que se encarga del contenido.
  }
}

// Define un widget privado llamado `_HomeView` que extiende `ConsumerStatefulWidget`.
// Esto indica que el widget es stateful (con estado mutable) y también puede consumir proveedores de Riverpod.
class _HomeView extends ConsumerStatefulWidget {
  // Constructor de la clase `_HomeView`
  const _HomeView();

  // Método que crea el estado del widget `_HomeView`.
  // Esto es necesario porque es un StatefulWidget.
  @override
  _HomeViewState createState() => _HomeViewState();
}

// Define la clase `_HomeViewState` que es el estado asociado al widget `_HomeView`.
// Extiende `ConsumerState` para poder usar el contexto de Riverpod.
class _HomeViewState extends ConsumerState<_HomeView> {
  // Método `initState` que se llama una vez cuando se inicializa el widget.
  @override
  void initState() {
    super.initState();

    // Carga la siguiente página de películas cuando se inicializa la vista.
    // Utiliza el proveedor `nowPlayingMoviesProvider` para cargar la página inicial de películas.
    ref.read(nowPlayingMoviesProvider.notifier).loadNextPage();
  }

  // Método `build` que construye la interfaz del widget.
  // En este caso, simplemente devuelve un `Placeholder`, que es un widget temporal.
  // Posteriormente, se podría reemplazar por la lógica real de la vista.
  @override
  Widget build(BuildContext context) {
    final nowPlayingMovies = ref.watch(nowPlayingMoviesProvider);

    if (nowPlayingMovies.length == 0) return CircularProgressIndicator();

    return ListView.builder(
      itemCount: nowPlayingMovies.length,
      itemBuilder: (context, index) {
        final movie = nowPlayingMovies[index];
        return ListTile(
          title: Text(movie.title),
          subtitle: Text(movie.overview),
        );
      },
    );
  }
}
