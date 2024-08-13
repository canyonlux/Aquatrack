import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:h2orienta/MapPage.dart';
import 'package:url_launcher/url_launcher.dart';
import 'RegisterPage.dart';
import 'main.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _login() async {
    try {
      final FirebaseAuth _auth = FirebaseAuth.instance;
      await _auth.signInWithEmailAndPassword(
        email: _emailController.text,
        password: _passwordController.text,
      );

      // Navegar a la página principal (MapPage) después del inicio de sesión exitoso
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => MapPage()),
      );
    } on FirebaseAuthException catch (e) {
      // Mostrar mensaje de error al usuario
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(e.message ?? "Ocurrió un error al iniciar sesión."),
        ),
      );
    }
  }

  // Función para abrir el enlace del patrocinador
  void _launchURL() async {
    final Uri url = Uri.parse('https://ac-torres.webnode.es/');
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("No se pudo abrir el enlace."),
        ),
      );
    }
  }

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
      body: SingleChildScrollView(
        child: Padding(
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
              // Campo de texto para el email/usuario
              TextField(
                controller: _emailController,
                decoration: InputDecoration(
                  labelText: 'Usuario',
                  // Resto de la configuración del TextField
                ),
              ),
              SizedBox(height: 20), // Espaciador
              // Campo de texto para la contraseña
              TextField(
                controller: _passwordController,
                obscureText: true,
                decoration: InputDecoration(
                  labelText: 'Contraseña',
                  // Resto de la configuración del TextField
                ),
              ),
              SizedBox(height: 20), // Espaciador
              // Botón de inicio de sesión
              ElevatedButton(
                onPressed: _login, // Actualizado para llamar a _login
                child: Text('Iniciar Sesión',
                    style: TextStyle(color: Colors.white)),
                style: ElevatedButton.styleFrom(
                  primary: Color(0xFF00B4D8), // Azul Secundario para botones
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30)),
                ),
              ),
              SizedBox(height: 20), // Espaciador
              // Botón para navegar al registro
              ElevatedButton(
                onPressed: () => Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => RegisterPage())),
                child: Text('Registrar', style: TextStyle(color: Colors.white)),
                style: ElevatedButton.styleFrom(
                  primary: Color(0xFF0077B6), // Azul Principal
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30)),
                ),
              ),
              SizedBox(height: 40), // Espaciador
              // Enlace de publicidad
              TextButton(
                onPressed: _launchURL,
                child: Text(
                  '¡Visita nuestro patrocinador! '
                      'AC Torres',
                  style: TextStyle(
                    color: Colors.redAccent, // Rojo llamativo para destacar
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      backgroundColor: Color(0xFFF1F1F1), // Fondo Gris claro
    );
  }
}
