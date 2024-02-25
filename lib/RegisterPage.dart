import 'package:flutter/material.dart';
import 'package:h2orienta/LoginPage.dart';

class RegisterPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Register Page'),
        backgroundColor: Color(0xFF0077B6), // Azul Principal para AppBar
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Imagen en la parte superior
            Image.asset(
              'assets/images/registerimage.jpg', // Asegúrate de que esta imagen esté en tu carpeta de assets
              height: 250,
            ),
            SizedBox(height: 20), // Espaciador
            // Campo de texto para el nombre
            _buildTextField(Icons.person_outline, 'Nombre'),
            SizedBox(height: 20), // Espaciador
            // Campo de texto para los apellidos
            _buildTextField(Icons.person_outline, 'Apellidos'),
            SizedBox(height: 20), // Espaciador
            // Campo de texto para el usuario
            _buildTextField(Icons.person, 'Usuario'),
            SizedBox(height: 20), // Espaciador
            // Campo de texto para la contraseña
            _buildTextField(Icons.lock, 'Contraseña', isPassword: true),
            SizedBox(height: 20), // Espaciador
            // Botones
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildButton(context, 'Create Account', LoginPage()),
                _buildButton(context, 'Cancelar', LoginPage()),
              ],
            ),
          ],
        ),
      ),
      backgroundColor: Color(0xFFF1F1F1), // Fondo Gris claro
    );
  }

  Widget _buildTextField(IconData icon, String label, {bool isPassword = false}) {
    return TextField(
      obscureText: isPassword,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(color: Color(0xFF333333)), // Texto Gris oscuro
        icon: Icon(icon, color: Color(0xFF0077B6)), // Icono Azul Principal
      ),
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
