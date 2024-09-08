//Importaciones de dart

//Importaciones de flutter
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
//Importaciones de terceros


//Importaciones propias
import 'package:cinemapedia/config/router/app_router.dart';
import 'package:cinemapedia/config/theme/app_theme.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() async {
   // Carga variables de entorno desde el archivo .env antes de inicializar la app
  await dotenv.load(fileName: '.env');

  runApp(
    // ProviderScope es necesario para que Riverpod maneje el estado y los providers en toda la app
   const ProviderScope(child: MainApp())
  );
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: appRouter,
      debugShowCheckedModeBanner: false,
      theme: AppTheme().getTheme(),
    );
  }
}
