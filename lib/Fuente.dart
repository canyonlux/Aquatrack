import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Fuente {
  final String idClienteEprinsa;
  final String identificador;
  final String direccion;
  final String coordenadaX;
  final String coordenadaY;
  final String zona;
  final String estado;
  final String fechaRevision;
  final String bebederoMascotas;
  final String municipio;

  Fuente({
    required this.idClienteEprinsa,
    required this.identificador,
    required this.direccion,
    required this.coordenadaX,
    required this.coordenadaY,
    required this.zona,
    required this.estado,
    required this.fechaRevision,
    required this.bebederoMascotas,
    required this.municipio,
  });

  factory Fuente.fromJson(Map<String, dynamic> json) {
    return Fuente(
      idClienteEprinsa: json['idClienteEprinsa'],
      identificador: json['Identificador'],
      direccion: json['Direccion'],
      coordenadaX: json['CoordenadaX'],
      coordenadaY: json['CoordenadaY'],
      zona: json['Zona'],
      estado: json['Estado'],
      fechaRevision: json['FechaRevision'],
      bebederoMascotas: json['BebederoMascotas'],
      municipio: json['Municipio'],
    );
  }
}
