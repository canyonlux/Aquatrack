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

class WelcomeScreen extends StatefulWidget {
  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    )..repeat(reverse: true);

    _animation = Tween<double>(begin: 50, end: 5).animate(_controller)
      ..addListener(() {
        setState(() {});
      });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF1F1F1), // Fondo Gris claro
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Transform.translate(
              offset: Offset(0, _animation.value),
              child: Image.asset('assets/images/aquatracklogo.webp', width: 1000 * 0.6, height: 1000 * 0.6),
            ),
            Text(
              'AquaTrack',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Color(0xFF0077B6), // Azul Principal para el título
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Tu guía para encontrar fuentes de agua durante tus actividades al aire libre',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  color: Color(0xFF333333), // Texto Gris oscuro
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 30.0),
              child: FloatingActionButton(
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => LoginPage()),
                  );
                },
                 child: Icon(Icons.water_drop, size: 40, color: Color(0xFF90E0EF),), // Icono de Gota de Agua
                backgroundColor: Color(0xFF0077B6),
                elevation: 10.0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ), heroTag: 'big_fab',
                materialTapTargetSize: MaterialTapTargetSize.padded,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
