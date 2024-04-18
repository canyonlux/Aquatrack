import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:h2orienta/configuracion/theme_preferences.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'Fuente.dart';
import 'FuentesFavoritasPage.dart';
import 'configuracion/theme_controller.dart';
import 'main.dart';

class UserProfilePage extends StatelessWidget {
  final String username;

  UserProfilePage({Key? key, required this.username}) : super(key: key);

  Future<void> _pickImage(BuildContext context) async {
    final ImagePicker picker = ImagePicker();
    // Selecciona imagen desde la galería
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      print('Imagen seleccionada: ${image.path}');
    }
  }

  Future<List<Fuente>> getFuentesFavoritas() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) return [];

    final favoritesRef =
        FirebaseFirestore.instance.collection('favoritos').doc(user.uid);
    final docSnapshot = await favoritesRef.get();
    final List<dynamic> favoritasIds = docSnapshot.data()?['fuentes'] ?? [];

    List<Fuente> fuentesFavoritas = [];

    for (String id in favoritasIds) {}

    return fuentesFavoritas;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Perfil de Usuario'),
        backgroundColor: Color(0xFF0077B6), // Azul Principal
      ),
      body: Container(
        padding: EdgeInsets.all(16.0),
        child: Center(
          // Centrando la interfaz
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              // Imagen del perfil de usuario
              CircleAvatar(
                radius: 100,
                backgroundImage:
                    AssetImage('assets/images/perfil.jpg'), // Imagen del perfil
              ),
              FloatingActionButton(
                onPressed: () => _pickImage(context),
                child: Icon(Icons.add, color: Colors.white),
                backgroundColor: Colors.green,
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

              _buildButton(context, 'Fuentes Favoritas', Icons.favorite),
              SizedBox(height: 10),
              _buildButton(context, 'Comentarios Realizados', Icons.comment),
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
        if (text == "Fuentes Favoritas") {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => FuentesFavoritasPage()),
          );
        } else if (text == "Configuraciones") {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              var themeController = context.read<
                  ThemeController>();
              bool isDark =
                  themeController.themeData.brightness == Brightness.dark;
              return AlertDialog(
                title: Text("Configuración"),
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    ListTile(
                      title: Text('Modo Oscuro'),
                      trailing: Switch(
                        value: isDark,
                        onChanged: (bool value) {
                          themeController.toggleTheme(value);
                          Navigator.of(context)
                              .pop(); // Cerrar diálogo para refrescar
                        },
                      ),
                    ),
                  ],
                ),
                actions: <Widget>[
                  TextButton(
                    onPressed: () => Navigator.of(context).pop(),
                    child: Text('Cerrar'),
                  ),
                ],
              );
            },
          );
        }
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
