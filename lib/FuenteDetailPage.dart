import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'Fuente.dart';

class FuenteDetailPage extends StatelessWidget {
  final Fuente fuente;

  FuenteDetailPage({required this.fuente});

  // Método para añadir la fuente a los favoritos
  void _addFavorite(BuildContext context) async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      DocumentReference favoritesRef = FirebaseFirestore.instance.collection('favoritos').doc(user.uid);
      favoritesRef.set({
        'fuentes': FieldValue.arrayUnion([fuente.identificador])
      }, SetOptions(merge: true)).then((_) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Añadido a favoritos'),
        ));
      }).catchError((e) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Error al añadir a favoritos'),
        ));
      });
    }
  }


  @override
  Widget build(BuildContext context) {
    // Obtener la altura total de la pantalla
    final screenHeight = MediaQuery.of(context).size.height;
    // Asegúrate de que el nombre de la imagen esté en minúsculas y sin espacios ni caracteres especiales.
    final imageName = fuente.municipio.split('(').last.trim().split(')').first.toLowerCase().replaceAll(' ', '_').replaceAll('á', 'a').replaceAll('é', 'e').replaceAll('í', 'i').replaceAll('ó', 'o').replaceAll('ú', 'u').replaceAll('ñ', 'n');

    return Scaffold(
      appBar: AppBar(
        title: Text(fuente.municipio),
        backgroundColor: Color(0xFF0077B6), // Azul Principal
          actions: [
      IconButton(
      icon: Icon(Icons.star_border), // Cambiar por icono lleno si ya está en favoritos
      onPressed: () => _addFavorite(context),
      ),
      ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              // Widget para mostrar la imagen
              Center(
                child: Container(
                  height: screenHeight / 2, // Usar la mitad de la altura de la pantalla para la imagen
                  width: double.infinity, // Que ocupe todo el ancho posible
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/images/$imageName.png'),
                      fit: BoxFit.cover, // Esto asegura que la imagen cubra el espacio asignado
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20), // Espaciado
              _buildInfoRow('ID Cliente Eprinsa:', fuente.idClienteEprinsa),
              _buildInfoRow('Identificador:', fuente.identificador),
              _buildInfoRow('Dirección:', fuente.direccion),
              _buildInfoRow('Coordenadas:', '${fuente.coordenadaX}, ${fuente.coordenadaY}'),
              _buildInfoRow('Zona:', fuente.zona),
              _buildInfoRow('Estado:', fuente.estado),
              _buildInfoRow('Fecha de Revisión:', fuente.fechaRevision),
              _buildInfoRow('Bebedero para Mascotas:', fuente.bebederoMascotas),
              _buildInfoRow('Municipio:', fuente.municipio),
            ],
          ),
        ),
      ),
      backgroundColor: Color(0xFFF1F1F1), // Fondo Gris claro
    );
  }

  Widget _buildInfoRow(String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: RichText(
        text: TextSpan(
          text: '$title ',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Color(0xFF333333), // Texto Gris oscuro
            fontSize: 16,
          ),
          children: <TextSpan>[
            TextSpan(
              text: value,
              style: TextStyle(
                fontWeight: FontWeight.normal,
                color: Color(0xFF0077B6), // Azul Principal
              ),
            ),
          ],
        ),
      ),
    );
  }
}
