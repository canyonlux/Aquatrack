import 'package:flutter/material.dart';
import 'package:h2orienta/MapPage.dart';
import 'RegisterPage.dart';
import 'main.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Login Page',
          style: TextStyle(
            color: Colors.white, // Texto del AppBar en blanco
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Color(0xFF0077B6), // Azul Principal para AppBar
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Logo en la parte superior
            Container(
              margin: EdgeInsets.only(bottom: 20.0),
              child: Image.asset(
                'assets/images/loginimage.webp',
                height: 150,
              ),
            ),
            // Campo de texto para el nombre de usuario
            TextField(
              decoration: InputDecoration(
                labelText: 'Usuario',
                labelStyle: TextStyle(color: Color(0xFF333333)), // Texto Gris oscuro
                icon: Icon(Icons.person, color: Color(0xFF0077B6)), // Icono Azul Principal
              ),
            ),
            SizedBox(height: 20), // Espaciador
            // Campo de texto para la contraseña
            TextField(
              obscureText: true,
              decoration: InputDecoration(
                labelText: 'Contraseña',
                labelStyle: TextStyle(color: Color(0xFF333333)), // Texto Gris oscuro
                icon: Icon(Icons.lock, color: Color(0xFF0077B6)), // Icono Azul Principal
              ),
            ),
            SizedBox(height: 20), // Espaciador
            // Botones
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildButton(context, 'Back', MyApp()),
                _buildButton(context, 'Login', MapPage()),
                _buildButton(context, 'Register', RegisterPage()),
              ],
            ),
          ],
        ),
      ),
      backgroundColor: Color(0xFFF1F1F1), // Fondo Gris claro
    );
  }

  Widget _buildButton(BuildContext context, String text, Widget page) {
    return ElevatedButton(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => page),
        );
      },
      child: Text(
        text,
        style: TextStyle(
          color: Colors.white, // Texto en blanco
        ),
      ),
      style: ElevatedButton.styleFrom(
        primary: Color(0xFF00B4D8), // Azul Secundario para botones
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30), // Bordes redondeados
        ),
      ),
    );
  }
}
