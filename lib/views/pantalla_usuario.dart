import 'package:flutter/material.dart';

class PantallaUsuario extends StatelessWidget {
  const PantallaUsuario({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightGreen[100],
      appBar: AppBar(title: Text('Mi Perfil'), centerTitle: true),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Card(
          elevation: 8,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
            side: BorderSide(color: Colors.white, width: 2),
          ),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                CircleAvatar(
                  radius: 60,
                  backgroundImage: AssetImage('lib/assets/julio.jpg'),
                ),
                SizedBox(height: 16),
                Text(
                  'Julio Alfonso Monteverde Esquer',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  'Aspirante a desarrollador con Flutter y Fan de las luchitas falsas.',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 16, color: Colors.grey[800]),
                ),
                Divider(height: 30, thickness: 1),
                InfoRow(
                  icon: Icons.mail,
                  label: 'Correo',
                  value: 'Julioalfo98@gmail.com',
                ),
                InfoRow(
                  icon: Icons.phone,
                  label: 'Telefono',
                  value: '+52 (662) 170 773',
                ),
                InfoRow(
                  icon: Icons.location_city,
                  label: 'Ciudad',
                  value: 'Hermosillo, Sonora',
                ),
                InfoRow(
                  icon: Icons.school,
                  label: 'Educacion',
                  value: 'Ingenieria en Informatica',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class InfoRow extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;

  const InfoRow({
    super.key,
    required this.icon,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0),
      child: Row(
        children: [
          Icon(icon, color: Colors.green[700]),
          SizedBox(width: 12),
          Text('$label:', style: TextStyle(fontWeight: FontWeight.bold)),
          SizedBox(width: 8),
          Expanded(
            child: Text(value, style: TextStyle(color: Colors.black87)),
          ),
        ],
      ),
    );
  }
}
