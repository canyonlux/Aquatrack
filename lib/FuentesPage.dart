import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'Fuente.dart';
import 'FuenteDetailPage.dart';

class FuentesPage extends StatelessWidget {
  Future<List<Fuente>> readJsonData() async {
    final jsondata =
        await rootBundle.loadString('assets/FuentesDeAgua_Almassora.json');
    final list = json.decode(jsondata) as List<dynamic>;

    return list.map((item) => Fuente.fromJson(item)).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Fuentes de Agua'),
        backgroundColor: Color(0xFF0077B6), // Azul Principal
      ),
      body: FutureBuilder(
        future: readJsonData(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(
                child: Text('Ha ocurrido un error',
                    style: TextStyle(
                        color: Color(
                            0xFF333333))));
          } else if (snapshot.hasData) {
            List<Fuente> data = snapshot.data as List<Fuente>;
            return ListView.builder(
              itemCount: data.length,
              itemBuilder: (context, index) {
                return Card(
                  margin: EdgeInsets.all(8.0),
                  child: ListTile(
                    leading: Icon(Icons.water_drop, color: Color(0xFF0077B6)),
                    // Icono personalizado
                    title: Text(
                      data[index].municipio,
                      style: TextStyle(
                          color: Color(0xFF333333),
                          fontWeight: FontWeight.bold), // Estilo para el título
                    ),
                    subtitle: Text(
                      data[index].estado,
                      style: TextStyle(
                          color: Color(0xFF00B4D8)), // Estilo para el subtítulo
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              FuenteDetailPage(fuente: data[index]),
                        ),
                      );
                    },
                  ),
                );
              },
            );
          } else {
            return Center(
                child: CircularProgressIndicator(
                    color: Color(
                        0xFF0077B6))); // Circular Progress Indicator con color personalizado
          }
        },
      ),
      backgroundColor: Color(0xFFF1F1F1), // Fondo Gris claro
    );
  }
}
