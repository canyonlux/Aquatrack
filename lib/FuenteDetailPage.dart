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
        backgroundColor: Color(0xFF0077B6), // Azul Principal
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
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
