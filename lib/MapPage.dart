import 'dart:convert';
import 'package:diacritic/diacritic.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'Fuente.dart';
import 'FuenteDetailPage.dart';
import 'FuentesPage.dart';
import 'UserProfilePage.dart';

class MapPage extends StatefulWidget {
  @override
  _MapPageState createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  List<Fuente> _fuentes = [];
  List<Fuente> _fuentesFiltradas = [];
  final TextEditingController _searchController = TextEditingController();
  int _currentIndex = 0;
  final MapController _mapController = MapController();

  @override
  void initState() {
    super.initState();
    _loadFuentes();
    _searchController.addListener(_filterFuentes);
  }
  Future<void> _loadFuentes() async {
    final jsondata = await rootBundle.loadString('assets/FuentesDeAgua_Almassora.json');
    final list = json.decode(jsondata) as List<dynamic>;
    setState(() {
      _fuentes = list.map((item) => Fuente.fromJson(item)).toList();
      _fuentesFiltradas = _fuentes;
    });
  }

  void _filterFuentes() {
    final query = removeDiacritics(_searchController.text.toLowerCase());
    setState(() {
      _fuentesFiltradas = _fuentes.where((fuente) {
        // Normalizar municipio y estado para la comparación
        final municipioNormalized = removeDiacritics(fuente.municipio.toLowerCase());
        final estadoNormalized = removeDiacritics(fuente.estado.toLowerCase());

        return municipioNormalized.contains(query) || estadoNormalized.contains(query);
      }).toList();
    });
  }

  void _onItemTapped(int index) {
    if (index == _currentIndex) return; // Evita recargar la misma página

    setState(() {
      _currentIndex = index;
    });

    switch (index) {
      case 1:
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => FuentesPage()));
        break;
      case 2:
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => UserProfilePage()));
        break;
    }
  }
  void _zoomIn() {
    _mapController.move(_mapController.center, _mapController.zoom + 1);
  }

  void _zoomOut() {
    _mapController.move(_mapController.center, _mapController.zoom - 1);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF0077B6),
        title: Container(
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.2),
            borderRadius: BorderRadius.circular(20),
          ),
          child: TextField(
            controller: _searchController,
            style: TextStyle(color: Colors.white),
            decoration: InputDecoration(
              prefixIcon: Icon(Icons.search, color: Colors.white),
              hintText: 'Buscar fuentes disponibles...',
              hintStyle: TextStyle(color: Colors.white),
              border: InputBorder.none,
            ),
          ),
        ),
      ),
      body: _searchController.text.isNotEmpty ? ListView.builder(
        itemCount: _fuentesFiltradas.length,
        itemBuilder: (context, index) {
          final fuente = _fuentesFiltradas[index];
          return ListTile(
            title: Text(fuente.direccion),
            subtitle: Text(fuente.municipio),
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => FuenteDetailPage(fuente: fuente)));
            },
          );
        },
      )
      : FlutterMap(
        mapController: _mapController,
        children: [
          TileLayer(
            urlTemplate: "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
            subdomains: ['a', 'b', 'c'],
          ),
        ],
        options: MapOptions(
          center: LatLng(39.9263, -0.0515),
          zoom: 13.0,
        ),
      ),
        floatingActionButton: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            FloatingActionButton(
              onPressed: _zoomIn,
              child: Icon(Icons.add),
              mini: true,
              backgroundColor: Color(0xFF0077B6),
            ),
            SizedBox(height: 10),
            FloatingActionButton(
              onPressed: _zoomOut,
              child: Icon(Icons.remove),
              mini: true,
              backgroundColor: Color(0xFF0077B6),
            ),
          ],
        ),

      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: _onItemTapped,
        backgroundColor: Color(0xFF0077B6),
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.map),
            label: 'Mapa',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.local_drink),
            label: 'Fuentes',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Perfil',
          ),
        ],
      ),
    );
  }
  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

}
