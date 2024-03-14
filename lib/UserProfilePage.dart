import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class UserProfilePage extends StatelessWidget {
  final String username;
  UserProfilePage({Key? key, required this.username}) : super(key: key);






  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Perfil de Usuario'),
        backgroundColor: Color(0xFF0077B6), // Azul Principal
      ),
      body: Container(
        padding: EdgeInsets.all(16.0),
        child: Center( // Centrando la interfaz
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              // Imagen del perfil de usuario
              CircleAvatar(
                radius: 100,
                backgroundImage: AssetImage('assets/images/perfil.jpg'), // Imagen del perfil
              ),
              SizedBox(height: 50),
              // Nombre del usuario
              Text(
                username,
                style: TextStyle(
                  fontSize: 22,
                  color: Color(0xFF333333), // Texto Gris oscuro
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10),
              // Información adicional del usuario
              Text(
                'Aventurero amante del agua',
                style: TextStyle(
                  fontSize: 16,
                  color: Color(0xFF0077B6), // Azul Principal
                ),
              ),
              SizedBox(height: 20),
              // Botones con nombres sofisticados
              _buildButton(context, 'Fuentes Favoritas', Icons.favorite),
              SizedBox(height: 10),
              _buildButton(context, 'Comentarios Realizados', Icons.comment),
              SizedBox(height: 10),
              _buildButton(context, 'Nivel Explorador', Icons.explore),
              SizedBox(height: 10),
              _buildButton(context, 'Configuraciones', Icons.settings),
            ],
          ),
        ),
      ),
      backgroundColor: Color(0xFFF1F1F1), // Fondo Gris claro
    );
  }

  Widget _buildButton(BuildContext context, String text, IconData icon) {
    return ElevatedButton.icon(
      onPressed: () {
        // Implementar acción del botón en el futuro
      },
      icon: Icon(icon, color: Colors.white),
      label: Text(
        text,
        style: TextStyle(color: Colors.white),
      ),
      style: ElevatedButton.styleFrom(
        primary: Color(0xFF00B4D8), // Azul Secundario
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30), // Bordes redondeados
        ),
      ),
    );
  }
}
