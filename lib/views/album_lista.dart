import 'package:flutter/material.dart';
import 'package:album_biblio/models/albumbiblio.dart';
import 'album_forma.dart';
import 'album_vista.dart';
import 'pantalla_usuario.dart';

class AlbumLista extends StatefulWidget {
  const AlbumLista({super.key});

  @override
  State<AlbumLista> createState() => _AlbumListaState();
}

class _AlbumListaState extends State<AlbumLista> {
  int selectedAlbum = 0;
  late AlbumBiblio albumes;

  @override
  void initState() {
    super.initState();
    albumes = AlbumBiblio();
    albumes.addAlbum(
      Album(
        titulo: "The Dark Side of the Moon",
        artista: "Pink Floyd",
        anio: 1973,
        gender: "Rock",
      ),
    );
    albumes.addAlbum(
      Album(
        titulo: "Pet Sounds",
        artista: "The Beach Boys",
        anio: 1966,
        gender: "Rock",
      ),
    );
    albumes.addAlbum(
      Album(
        titulo: "OK Computer",
        artista: "Radiohead",
        anio: 1997,
        gender: "Rock",
      ),
    );
    albumes.addAlbum(
      Album(
        titulo: "Who's next",
        artista: "The Who",
        anio: 1971,
        gender: "Rock",
      ),
    );
    albumes.addAlbum(
      Album(
        titulo: "Nevermind",
        artista: "Nirvana",
        anio: 1991,
        gender: "Rock",
      ),
    );
    albumes.addAlbum(
      Album(
        titulo: "Off the Wall",
        artista: "Michael Jackson",
        anio: 1979,
        gender: "Pop",
      ),
    );
    albumes.addAlbum(
      Album(
        titulo: "Blonde on Blonde",
        artista: "Bob Dylan",
        anio: 1966,
        gender: "Blues Rock",
      ),
    );
    albumes.addAlbum(
      Album(
        titulo: "Born to Run",
        artista: "Bruce Springsteen",
        anio: 1975,
        gender: "Blues Rock",
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text("Biblioteca de Albumes"),
        actions: [
          PopupMenuButton(
            itemBuilder: (context) => <PopupMenuEntry>[
              const PopupMenuItem(value: 1, child: Text("Perfil de Usuario")),
              const PopupMenuItem(value: 2, child: Text("Acerca de ...")),
            ],
            onSelected: (value) {
              setState(() {
                if (value == 1) {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => const PantallaUsuario(),
                    ),
                  );
                } else if (value == 2) {}
              });
            },
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(10),
        children: ListTile.divideTiles(
          context: context,
          tiles: crearLista(),
          color: Colors.amber,
        ).toList(),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: agregarAlbum,
        tooltip: 'Nuevo album',
        child: const Icon(Icons.add),
      ),
    );
  }

  List<Widget> crearLista() {
    final List<Widget> lista = <Widget>[];
    for (int i = 0; i < albumes.albumes.length; i++) {
      Album album = albumes.albumes[i];
      lista.add(
        ListTile(
          leading: const Icon(Icons.album),
          title: Text(album.titulo),
          subtitle: Text(
            "${album.artista},  Año: ${album.anio},  Genero: ${album.gender}",
          ),
          trailing: SizedBox(
            width: 120,
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: crearButtonsBar(i),
            ),
          ),
          textColor: Colors.white,
          tileColor: Colors.lightBlue,
          selectedColor: Colors.blue,
          selectedTileColor: Colors.deepOrange.shade100,
          selected: (selectedAlbum == i),
          onTap: () => albumTapped(i),
        ),
      );
    }
    return lista;
  }

  void albumTapped(int i) {
    setState(() {
      selectedAlbum = i;
    });
  }

  Widget crearButtonsBar(int index) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        IconButton(
          tooltip: "Ver",
          onPressed: () {
            mostrarAlbum(context, index);
          },
          icon: const Icon(Icons.search),
        ),
        IconButton(
          tooltip: "Editar",
          onPressed: () {
            editarAlbum(index);
          },
          icon: const Icon(Icons.edit),
        ),
        IconButton(
          tooltip: "Eliminar",
          onPressed: () {
            confirmarEliminacion(index);
          },
          icon: const Icon(Icons.delete),
        ),
      ],
    );
  }

  //VIEW
  void mostrarAlbum(BuildContext context, int index) {
    Album album = albumes.getAlbumByIndex(index);
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => AlbumVista(album: albumes.getAlbumByIndex(index)),
      ),
    );
  }

  //EDIT
  void editarAlbum(int index) async {
    Album albumAEditar = albumes.getAlbumByIndex(index);
    final albumActualizado = await Navigator.of(context).push<Album>(
      MaterialPageRoute(builder: (context) => AlbumForma(album: albumAEditar)),
    );

    if (albumActualizado != null) {
      setState(() {
        albumes.updateAlbum(index, albumActualizado);
      });
    }
  }

  //DELETE
  void confirmarEliminacion(int index) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Confirmar Eliminación'),
          content: Text(
            '¿Esta seguro de que desea eliminar el album "${albumes.getAlbumByIndex(index).titulo}"?',
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancelar'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Eliminar'),
              onPressed: () {
                setState(() {
                  albumes.removeAlbum(index);
                });
                Navigator.of(context).pop();
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Album eliminado'),
                    duration: Duration(seconds: 2),
                  ),
                );
              },
            ),
          ],
        );
      },
    );
  }

  // ADD
  void agregarAlbum() async {
    final nuevoAlbum = await Navigator.of(
      context,
    ).push<Album>(MaterialPageRoute(builder: (context) => const AlbumForma()));

    if (nuevoAlbum != null) {
      setState(() {
        albumes.addAlbum(nuevoAlbum);
      });
    }
  }
}
