import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:h2orienta/LoginPage.dart';
import 'main.dart';

class RegisterPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Register Page'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Campo de texto para el nombre de usuario
            TextField(
              decoration: InputDecoration(
                labelText: 'Usuario',
                icon: Icon(Icons.person),
              ),
            ),
            SizedBox(height: 20), // Espaciador
            // Campo de texto para la contraseña
            TextField(
              obscureText: true,
              decoration: InputDecoration(
                labelText: 'Contraseña',
                icon: Icon(Icons.lock),
              ),
            ),
            SizedBox(height: 20), // Espaciador
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                // Botón de Crear Cuenta
                ElevatedButton(
                  onPressed: () {
                    // Navegar a la página principal
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => LoginPage()),
                    );
                  },
                  child: Text('Create Account'),
                ),
                // Botón de Cancelar
                ElevatedButton(
                  onPressed: () {
                    // Navegar a la página principal
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => LoginPage()),
                    );
                  },
                  child: Text('Cancelar'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}