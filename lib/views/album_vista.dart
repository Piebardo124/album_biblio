import 'package:flutter/material.dart';
import 'package:album_biblio/models/albumbiblio.dart';
//import 'package:album_biblio/models/album.dart';

class AlbumVista extends StatelessWidget {
  final Album album;

  const AlbumVista({super.key, required this.album});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFAECDE0),
      appBar: AppBar(title: Text(' Album '), centerTitle: true),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Card(
          color: Color(0xFFD4A04D),
          elevation: 8,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
            side: BorderSide(color: Colors.white, width: 2),
          ),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                ClipRRect(
                  borderRadius: BorderRadiusGeometry.circular(10.0),
                  child: Image.asset('lib/assets/parcels.jpg'),
                ),
                SizedBox(height: 16),
                const Text(
                  'Titulo: ',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                Text(
                  album.titulo,
                  style: TextStyle(fontSize: 20, color: Colors.black),
                ),
                Divider(height: 30, thickness: 1),
                const Text(
                  'Artista: ',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                Text(
                  album.artista,
                  style: TextStyle(fontSize: 20, color: Colors.black),
                ),
                Divider(height: 30, thickness: 1),
                const Text(
                  'Año de lanzamiendo: ',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                Text(
                  album.anio.toString(),
                  style: TextStyle(fontSize: 20, color: Colors.black),
                ),
                const Text(
                  'Genero: ',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                Text(
                  album.gender,
                  style: TextStyle(fontSize: 20, color: Colors.black),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
