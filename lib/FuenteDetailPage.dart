import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'Fuente.dart';

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
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Necesitas estar logueado para agregar a favoritos')));
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
      if (fuentes.contains(widget.fuente.identificador)) {
        // Si la fuente ya está en favoritos, la eliminamos
        transaction.update(favoritesRef, {'fuentes': FieldValue.arrayRemove([widget.fuente.identificador])});
        setState(() => _isFavorite = false);
      } else {
        // Si la fuente no está en favoritos, la añadimos
        transaction.update(favoritesRef, {'fuentes': FieldValue.arrayUnion([widget.fuente.identificador])});
        setState(() => _isFavorite = true);
      }
    }).then((result) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(_isFavorite ? 'Añadido a favoritos' : 'Eliminado de favoritos')));
    }).catchError((error) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Error al actualizar favoritos')));
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
              _buildInfoRow('ID Cliente Eprinsa:', widget.fuente.idClienteEprinsa),
              _buildInfoRow('Identificador:', widget.fuente.identificador),
              _buildInfoRow('Dirección:', widget.fuente.direccion),
              _buildInfoRow('Coordenadas:', '${widget.fuente.coordenadaX}, ${widget.fuente.coordenadaY}'),
              _buildInfoRow('Zona:', widget.fuente.zona),
              _buildInfoRow('Estado:', widget.fuente.estado),
              _buildInfoRow('Fecha de Revisión:', widget.fuente.fechaRevision),
              _buildInfoRow('Bebedero para Mascotas:', widget.fuente.bebederoMascotas),
              _buildInfoRow('Municipio:', widget.fuente.municipio),
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
