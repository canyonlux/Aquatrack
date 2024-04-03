import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'Fuente.dart';
import 'package:url_launcher/url_launcher.dart';

// Convertir en StatefulWidget
class FuenteDetailPage extends StatefulWidget {
  final Fuente fuente;

  FuenteDetailPage({required this.fuente});

  @override
  _FuenteDetailPageState createState() => _FuenteDetailPageState();
}

class _FuenteDetailPageState extends State<FuenteDetailPage> {
  bool _isFavorite = false;

  @override
  void initState() {
    super.initState();
    _checkFavoriteStatus();
  }
  Future<void> _openMap(double lat, double lng) async {
    final String googleMapsUrl = "https://www.google.com/maps/search/?api=1&query=$lat,$lng";
    try {
      bool launched = await launch(googleMapsUrl);
      if (!launched) {
        // Log o mostrar un mensaje de error si no se pudo abrir la URL
        print('No se pudo lanzar $googleMapsUrl');
      }
    } catch (e) {
      // Manejar el error
      print('Error al abrir Google Maps: $e');
    }
  }


  Future<void> _checkFavoriteStatus() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      DocumentReference favoritesRef = FirebaseFirestore.instance.collection('favoritos').doc(user.uid);
      var doc = await favoritesRef.get();
      if (doc.exists && (doc.data() as Map<String, dynamic>)['fuentes'].contains(widget.fuente.identificador)) {
        setState(() {
          _isFavorite = true;
        });
      }
    }
  }


  void _toggleFavorite(BuildContext context) async {
    final User? user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Necesitas estar logueado para agregar a favoritos'),
          backgroundColor: Color(0xFF0077B6),));
      return;
    }

    final DocumentReference favoritesRef = FirebaseFirestore.instance.collection('favoritos').doc(user.uid);

    FirebaseFirestore.instance.runTransaction((transaction) async {
      final DocumentSnapshot txSnapshot = await transaction.get(favoritesRef);

      if (!txSnapshot.exists) {
        throw Exception("El documento no existe!");
      }

      // Asegúrate de manejar correctamente los datos como un Map<String, dynamic>
      final data = txSnapshot.data() as Map<String, dynamic>;
      List<dynamic> fuentes = data['fuentes'] ?? [];
      if (fuentes.contains(widget.fuente.direccion)) {
        // Si la fuente ya está en favoritos, la eliminamos
        transaction.update(favoritesRef, {'fuentes': FieldValue.arrayRemove([widget.fuente.direccion])});
        setState(() => _isFavorite = false);
      } else {
        // Si la fuente no está en favoritos, la añadimos
        transaction.update(favoritesRef, {'fuentes': FieldValue.arrayUnion([widget.fuente.direccion ])});
        setState(() => _isFavorite = true);
      }
    }).then((result) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(_isFavorite ? 'Añadido a favoritos' : 'Eliminado de favoritos'),
        backgroundColor: Color(0xFF0077B6), // Azul Principal para el fondo del SnackBar
      ));
    }).catchError((error) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Error al actualizar favoritos'),
        backgroundColor: Color(0xFF0077B6), // Azul Principal para el fondo del SnackBar
      ));
    });
  }




  @override
  Widget build(BuildContext context) {
    // Obtener la altura total de la pantalla
    final screenHeight = MediaQuery.of(context).size.height;
    // Asegúrate de que el nombre de la imagen esté en minúsculas y sin espacios ni caracteres especiales.
    final imageName = widget.fuente.municipio.split('(').last.trim().split(')').first.toLowerCase().replaceAll(' ', '_').replaceAll('á', 'a').replaceAll('é', 'e').replaceAll('í', 'i').replaceAll('ó', 'o').replaceAll('ú', 'u').replaceAll('ñ', 'n');

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.fuente.municipio),
        backgroundColor: Color(0xFF0077B6), // Azul Principal
        actions: <Widget>[
          IconButton(
            icon: Icon(_isFavorite ? Icons.star : Icons.star_border),
            onPressed: () => _toggleFavorite(context),
            color: Colors.amber, // Color Dorado para la estrella
            iconSize: 30, // Tamaño más grande para la estrella
          ),
      ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Center(
                child: Container(
                  height: screenHeight / 2,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/images/$imageName.png'),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20),
              _buildInfoRow('Dirección:', widget.fuente.direccion),
              _buildInfoRow('Coordenadas:', '${widget.fuente.coordenadaX}, ${widget.fuente.coordenadaY}'),
              _buildInfoRow('Zona:', widget.fuente.zona),
              _buildInfoRow('Estado:', widget.fuente.estado),
              _buildInfoRow('Bebedero para Mascotas:', widget.fuente.bebederoMascotas),
              _buildInfoRow('Municipio:', widget.fuente.municipio),
              SizedBox(height: 20),
              Center(
                child: ElevatedButton.icon(
                  icon: Icon(Icons.directions, color: Colors.white),
                  label: Text('Cómo llegar'),
                  onPressed: () => _openMap(double.parse(widget.fuente.coordenadaX), double.parse(widget.fuente.coordenadaY)),
                  style: ElevatedButton.styleFrom(
                    primary: Color(0xFF0077B6), // Background color
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
