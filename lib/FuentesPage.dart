import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'Fuente.dart';
import 'FuenteDetailPage.dart';
class FuentesPage extends StatelessWidget {
  Future<List<Fuente>> readJsonData() async {
    final jsondata = await rootBundle.loadString('assets/03_009_fuentes_publicas_de_agua_potable (Provincial).json');
    final list = json.decode(jsondata) as List<dynamic>;

    return list.map((item) => Fuente.fromJson(item)).toList();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Fuentes de agua'),
      ),
      body: FutureBuilder(
        future: readJsonData(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Center(child: Text('Ha ocurrido un error')); // Add const here
          } else if (snapshot.hasData) {
            List<Fuente> data = snapshot.data as List<Fuente>;
            return ListView.builder(
              itemCount: data.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(data[index].municipio),
                  subtitle: Text(data[index].estado),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => FuenteDetailPage(fuente: data[index]),
                      ),
                    );
                  },
                );
              },
            );
          } else {
            return const Center(child: CircularProgressIndicator()); // Add const here
          }
        },
      ),
    );
  }
}
