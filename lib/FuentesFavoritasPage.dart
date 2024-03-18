import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'Fuente.dart';

class FuentesFavoritasPage extends StatelessWidget {

  Future<Fuente?> fetchFuenteById(String id) async {
    try {
      // Asume que cada fuente está en una colección llamada 'fuentes' y su ID es el identificador del documento
      DocumentSnapshot docSnapshot = await FirebaseFirestore.instance.collection('fuentes').doc(id).get();

      if (!docSnapshot.exists) {
        return null;
      }

      // Asume que tus documentos de fuente tienen una estructura que coincide con tu clase Fuente
      return Fuente.fromJson(docSnapshot.data() as Map<String, dynamic>);
    } catch (e) {
      print("Error al obtener fuente por ID: $e");
      return null;
    }
  }

  Future<List<Fuente>> getFuentesFavoritas() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) throw Exception('Usuario no logueado');

    final favoritesRef = FirebaseFirestore.instance.collection('favoritos').doc(user.uid);
    final docSnapshot = await favoritesRef.get();

    if (!docSnapshot.exists) return [];

    final data = docSnapshot.data() as Map<String, dynamic>; // Castear correctamente
    final favoriteIds = data['fuentes'] as List<dynamic> ?? [];

    List<Future<Fuente?>> futureFuentes = favoriteIds.map((id) => fetchFuenteById(id.toString())).toList();
    List<Fuente> favoriteFuentes = (await Future.wait(futureFuentes)).whereType<Fuente>().toList();

    return favoriteFuentes;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Fuentes Favoritas'),
      ),
      body: FutureBuilder<List<Fuente>>(
        future: getFuentesFavoritas(), // Asegúrate de implementar esta función
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          if (snapshot.error != null || !snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No tienes fuentes favoritas aún'));
          }

          List<Fuente> fuentesFavoritas = snapshot.data!;
          return ListView.builder(
            itemCount: fuentesFavoritas.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(fuentesFavoritas[index].identificador),
                // Añade aquí más propiedades y un onTap si es necesario
              );
            },
          );
        },
      ),
    );
  }
}
