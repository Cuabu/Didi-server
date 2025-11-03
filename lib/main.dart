import 'package:flutter/material.dart';
import 'recibir_pasajero.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Recibir del Pasajero',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: RecibirPasajeroPage(), // Aquí cargamos tu pantalla personalizada
    );
  }
}