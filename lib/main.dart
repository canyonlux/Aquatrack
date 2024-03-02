import 'package:flutter/material.dart';
import 'LoginPage.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'AquaTrack',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Color(0xFF0077B6), // Azul Principal
        hintColor: Color(0xFF90E0EF), // Color de Acento
        fontFamily: 'Roboto', // Fuente predeterminada
      ),
      home: WelcomeScreen(),
    );
  }
}

class WelcomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Positioned.fill(
            child: Image.asset(
              'assets/images/Titulo.jpg',
              fit: BoxFit.cover,
            ),
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Encuentra fuentes de agua durante tus actividades al aire libre',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  color: Color(0xFFFFFFFF), // Texto Blanco
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 50,
            left: 0,
            right: 0,
            child: Center(
              child: ElevatedButton(
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(builder: (context) => LoginPage()));
                },
                child: Text(
                  'INICIO',
                  style: TextStyle(
                    color: Colors.white, // Texto en blanco
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  primary: Color(0xFF00B4D8), // Azul Secundario para botones
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30), // Bordes redondeados
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15), // Espaciado interno
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
