// Dart
import 'package:flutter/material.dart';
import 'Fuente.dart';

class FuenteDetailPage extends StatelessWidget {
  final Fuente fuente;

  FuenteDetailPage({required this.fuente});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(fuente.municipio),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text('ID Cliente Eprinsa: ${fuente.idClienteEprinsa}'),
            Text('Identificador: ${fuente.identificador}'),
            Text('Dirección: ${fuente.direccion}'),
            Text('Coordenada X: ${fuente.coordenadaX}'),
            Text('Coordenada Y: ${fuente.coordenadaY}'),
            Text('Zona: ${fuente.zona}'),
            Text('Estado: ${fuente.estado}'),
            Text('Fecha de Revisión: ${fuente.fechaRevision}'),
            Text('Bebedero para Mascotas: ${fuente.bebederoMascotas}'),
            Text('Municipio: ${fuente.municipio}'),
          ],
        ),
      ),
    );
  }
}