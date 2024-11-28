import 'package:flutter/material.dart';
import 'package:op_flutter_challenge/pages/pages.dart';
import 'package:op_flutter_challenge/providers/people_provider.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => PeopleProvider(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Personajes Star Wars',
      debugShowCheckedModeBanner: false,
      routes: {
        '/favorites': (context) => const FavoritesPage(),
      },
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          brightness: Brightness.dark,
          seedColor: const Color.fromARGB(255, 244, 236, 3),
          surface: Colors.black87,
          tertiary: const Color.fromARGB(255, 41, 41, 41),
        ),
        useMaterial3: true,
      ),
      home: const HomePage(),
    );
  }
}
