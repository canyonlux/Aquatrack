import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'Fuente.dart';

class FuentesFavoritasPage extends StatefulWidget {
  @override
  _FuentesFavoritasPageState createState() => _FuentesFavoritasPageState();
}

class _FuentesFavoritasPageState extends State<FuentesFavoritasPage> {
  // Recupera las direcciones de las fuentes favoritas del usuario actual
  Future<List<String>> getFuentesFavoritasDirecciones() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) throw Exception('Usuario no logueado');

    final docSnapshot = await FirebaseFirestore.instance
        .collection('favoritos')
        .doc(user.uid)
        .get();

    if (!docSnapshot.exists) return [];

    final direcciones = List.from(docSnapshot.data()?['fuentes'] ?? []);
    return direcciones.cast<String>();
  }

  // Recupera los objetos Fuente basados en las direcciones
  Future<List<Fuente?>> getFuentesFavoritas() async {
    final direcciones = await getFuentesFavoritasDirecciones();
    return await fetchFuentesPorDireccion(direcciones);
  }

  Future<List<Fuente?>> fetchFuentesPorDireccion(
      List<String> direcciones) async {
    List<Fuente?> fuentes = [];

    for (String direccion in direcciones) {
      var querySnapshot = await FirebaseFirestore.instance
          .collection('fuentes')
          .where(FieldPath.documentId, isEqualTo: direccion)
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        var doc = querySnapshot.docs.first;
        fuentes.add(Fuente.fromJson(doc.data() as Map<String, dynamic>));
      } else {
        print("No se encontró la fuente con identificador: $direccion");
        fuentes.add(null);
      }
    }

    return fuentes;
  }

  // Construye la UI de la página
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Fuentes Favoritas'),
        backgroundColor: Color(0xFF0077B6),
      ),
      body: FutureBuilder<List<Fuente?>>(
        future: getFuentesFavoritas(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          if (snapshot.error != null ||
              !snapshot.hasData ||
              snapshot.data!.isEmpty) {
            return Center(child: Text('No tienes fuentes favoritas aún.'));
          }

          var fuentesFavoritas = snapshot.data!;
          return ListView.builder(
            itemCount: fuentesFavoritas.length,
            itemBuilder: (context, index) {
              var fuente = fuentesFavoritas[index];
              if (fuente != null) {
                return buildFuenteCard(context, fuente);
              } else {
                return ListTile(
                  title: Text('Fuente no encontrada'),
                );
              }
            },
          );
        },
      ),
    );
  }

  Widget buildFuenteCard(BuildContext context, Fuente fuente) {
    final imageName = fuente.direccion
        .toLowerCase()
        .replaceAll(' ', '_')
        .replaceAll('á', 'a')
        .replaceAll('é', 'e')
        .replaceAll('í', 'i')
        .replaceAll('ó', 'o')
        .replaceAll('ú', 'u')
        .replaceAll('ñ', 'n');

    return Card(
      clipBehavior: Clip.antiAlias, // Para dar un efecto visual más pulido
      child: Column(
        children: <Widget>[
          Image.asset('assets/images/$imageName.png',
              height: 200, fit: BoxFit.cover),
          ListTile(
            title: Text(fuente.direccion),
            subtitle: Text(fuente.direccion),
            onTap: () {},
          ),
        ],
      ),
    );
  }
}
