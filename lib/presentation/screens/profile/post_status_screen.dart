import 'package:flutter/material.dart';

void main() {
  runApp(PostStatusScreen());
}

class PostStatusScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: ReportPage(),
    );
  }
}

class ReportPage extends StatefulWidget {
  @override
  _ReportPageState createState() => _ReportPageState();
}

class _ReportPageState extends State<ReportPage> {
  List<Map<String, String>> activeReports = [
    {
      'name': 'Peter',
      'breed': 'Beagle Dog',
      'age': '1.5 years old',
      'status': 'En búsqueda de hogar',
      'location': 'Pueblo Libre, Lima',
      'imageUrl': 'https://media.licdn.com/dms/image/v2/C4E03AQEp55lSR4WuIw/profile-displayphoto-shrink_400_400/profile-displayphoto-shrink_400_400/0/1657679721882?e=2147483647&v=beta&t=JEDBdZmahqY1tiw1kWegxfx20OOG6QIDfUdtU3EBTiE',
    },
  ];

  List<Map<String, String>> archivedReports = [
    {
      'name': 'Carla',
      'breed': 'Pomeranian Dog',
      'age': '1 year old',
      'status': 'Adoptado :D',
      'location': 'Comas, Lima',
      'imageUrl': 'https://media.licdn.com/dms/image/v2/C4E03AQEp55lSR4WuIw/profile-displayphoto-shrink_400_400/profile-displayphoto-shrink_400_400/0/1657679721882?e=2147483647&v=beta&t=JEDBdZmahqY1tiw1kWegxfx20OOG6QIDfUdtU3EBTiE',
    },
  ];

  void archiveReport(int index) {
    setState(() {
      archivedReports.add(activeReports[index]);
      activeReports.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('AdoptMe'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'Mis reportes',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: activeReports.length,
              itemBuilder: (context, index) {
                return ReportCard(
                  report: activeReports[index],
                  onArchive: () => archiveReport(index),
                );
              },
            ),
          ),
          Divider(),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'Archivados',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: archivedReports.length,
              itemBuilder: (context, index) {
                return ReportCard(
                  report: archivedReports[index],
                  onArchive: null, // Deshabilitamos funcionalidad
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class ReportCard extends StatelessWidget {
  final Map<String, String> report;
  final VoidCallback? onArchive;

  const ReportCard({required this.report, this.onArchive});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8.0),
              child: Image.network(
                report['imageUrl']!,
                width: 70,
                height: 70,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(width: 16.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    report['name']!,
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  Text(report['breed']!),
                  Text(report['age']!),
                  Text(
                    report['status']!,
                    style: TextStyle(color: Colors.grey[700]),
                  ),
                  Text(
                    report['location']!,
                    style: TextStyle(color: Colors.black54),
                  ),
                ],
              ),
            ),
            PopupMenuButton<String>(
              onSelected: (value) {
                if (value == 'Archivar') {
                  onArchive?.call();
                }
              },
              itemBuilder: (context) => [
                PopupMenuItem(
                  value: 'Archivar',
                  child: Text('Archivar'),
                ),
                PopupMenuItem(
                  value: 'Eliminar',
                  child: Text('Eliminar'),
                ),
                PopupMenuItem(
                  value: 'Cancelar',
                  child: Text('Cancelar'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
