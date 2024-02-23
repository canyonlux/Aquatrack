import 'package:flutter/material.dart';
import 'package:h2orienta/MapPage.dart';
import 'FuentesPage.dart';
import 'RegisterPage.dart';
import 'main.dart';


class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login Page'),
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
                'assets/images/gota-agua.webp', // Ajusta la ruta de tu logotipo
                height: 100,
              ),
            ),
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
            // Botón de inicio de sesión
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                // Botón de inicio de sesión
                ElevatedButton(
                  onPressed: () {
                    // Navegar a la página principal
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => MyApp()),
                    );
                  },
                  child: Text('Back'),
                ),
                // Botón de inicio de sesión
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => MapPage()),
                    );
                  },
                  child: Text('Login'),
                ),
                // Botón de registro
                ElevatedButton(
                  onPressed: () {
                    // Navegar a la página de registro
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => RegisterPage()),
                    );
                  },
                  child: Text('Register'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}