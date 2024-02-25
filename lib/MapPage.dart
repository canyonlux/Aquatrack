import 'package:flutter/material.dart';
import 'FuentesPage.dart';
import 'UserProfilePage.dart';
import 'main.dart'; // Asegúrate de tener esta página

class MapPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Mapa de Fuentes'),
        backgroundColor: Color(0xFF0077B6), // Azul Principal
      ),
      body: Center(
        child: Image.asset(
          'assets/images/map.jpg',
          height: 700,
          width: 400,
          fit: BoxFit.cover,
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Color(0xFFF1F1F1), // Fondo Gris claro
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Inicio',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Usuario',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.list),
            label: 'Fuentes',
          ),
        ],
        selectedItemColor: Color(0xFF0077B6), // Azul Principal para ítems seleccionados
        unselectedItemColor: Color(0xFF00B4D8), // Azul Secundario para ítems no seleccionados
        onTap: (index) {
          switch (index) {
            case 0:
              Navigator.push(context, MaterialPageRoute(builder: (context) => WelcomeScreen()));
              break;
            case 1:
              Navigator.push(context, MaterialPageRoute(builder: (context) => UserProfilePage()));
              break;
            case 2:
              Navigator.push(context, MaterialPageRoute(builder: (context) => FuentesPage()));
              break;
          }
        },
      ),
    );
  }
}
