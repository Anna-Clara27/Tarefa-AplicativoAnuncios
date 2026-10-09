import 'package:flutter/material.dart';
import 'screens/home_screen.dart';

void main() {
  runApp(const MercadoLivreApp());
}

class MercadoLivreApp extends StatelessWidget {
  const MercadoLivreApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Mercado Livre',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF3483FA),
        ),
      ),
      home: const HomeScreen(),
    );
  }
}