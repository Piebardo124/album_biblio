import 'package:flutter/material.dart';
import 'package:album_biblio/models/albumbiblio.dart';

class AlbumForma extends StatefulWidget {
  final Album? album;

  const AlbumForma({super.key, this.album});
  @override
  State<AlbumForma> createState() => _AlbumFormaState();
}

class _AlbumFormaState extends State<AlbumForma> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _tituloController;
  late TextEditingController _artistaController;
  late TextEditingController _anioController;
  late TextEditingController _genderController;

  @override
  void initState() {
    super.initState();
    _tituloController = TextEditingController(text: widget.album?.titulo ?? '');
    _artistaController = TextEditingController(
      text: widget.album?.artista ?? '',
    );
    _anioController = TextEditingController(
      text: widget.album?.anio.toString() ?? '',
    );
    _genderController = TextEditingController(text: widget.album?.gender ?? '');
  }

  @override
  void dispose() {
    _tituloController.dispose();
    _artistaController.dispose();
    _anioController.dispose();
    _genderController.dispose();
    super.dispose();
  }

  @override
  void _guardarFormulario() {
    if (_formKey.currentState!.validate()) {
      final nuevoAlbum = Album(
        id: widget.album?.id,
        titulo: _tituloController.text,
        artista: _artistaController.text,
        anio: int.tryParse(_anioController.text) ?? 0,
        gender: _genderController.text,
      );
      Navigator.of(context).pop(nuevoAlbum);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.album == null ? 'Agregar Álbum' : 'Editar Álbum'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: _tituloController,
                decoration: const InputDecoration(labelText: 'Título'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingrese un título';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _artistaController,
                decoration: const InputDecoration(labelText: 'Artista'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingrese un artista';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _anioController,
                decoration: const InputDecoration(labelText: 'Año'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null ||
                      value.isEmpty ||
                      int.tryParse(value) == null) {
                    return 'Por favor ingrese un año válido';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _genderController,
                decoration: const InputDecoration(labelText: 'Género'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingrese un género';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _guardarFormulario,
                child: const Text('Guardar'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
