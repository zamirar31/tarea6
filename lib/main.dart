import 'package:flutter/material.dart';
import 'package:flutter_application_tarea6/interfaces/noticias.dart';
import 'package:flutter_application_tarea6/providers/provider_noticias.dart';

void main() => runApp(const MainApp());

class MainApp extends StatelessWidget {
  const MainApp({Key? key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('DataTable Tarea'),
          backgroundColor: Colors.green,
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: showList(),
        ),
      ),
    );
  }

  Widget showList() {
    ScrollController _scrollController = ScrollController();

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: FutureBuilder<List<Noticias>>(
          future: listNoticias.cargarNoticias(),
          initialData: [],
          builder: (context, AsyncSnapshot<List<Noticias>> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else {
              return DataTable(
                columnSpacing: 10.0,
                dividerThickness: 1.0,
                headingRowColor:
                    MaterialStateColor.resolveWith((states) => Colors.green),
                columns: [
                  DataColumn(
                      label: Text('Titulo',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 12,
                              color: Colors.white))),
                  DataColumn(
                      label: Text('Descripción',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 12,
                              color: Colors.white))),
                  DataColumn(
                      label: Text('Icono',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 12,
                              color: Colors.white))),
                  DataColumn(
                      label: Text('Fecha',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 12,
                              color: Colors.white))),
                ],
                rows: listWidgetNoticias(snapshot.data!, context),
              );
            }
          },
        ),
      ),
    );
  }

  IconData getIconData(String iconName) {
    switch (iconName) {
      case 'accessibility_new':
        return Icons.accessibility_new;
      case 'autorenew':
        return Icons.autorenew;
      case 'add_a_photo':
        return Icons.add_a_photo;
      case 'add_business':
        return Icons.add_business;
      case 'add_moderator':
        return Icons.add_moderator;

      default:
        return Icons.error; // Un icono predeterminado para casos no mapeados
    }
  }

  List<DataRow> listWidgetNoticias(List<Noticias> data, BuildContext context) {
    return data.map((Noticias noticias) {
      return DataRow(
        cells: [
          DataCell(
            Container(
              width: 100.0,
              child: Text(
                noticias.titulo,
                style: TextStyle(fontSize: 10.0),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
          DataCell(
            Container(
              width: 120.0,
              child: Text(
                noticias.descripcion,
                style: TextStyle(fontSize: 10.0),
                maxLines: 20,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
          DataCell(
            Container(
              width: 50.0,
              height: 30.0,
              child: Icon(
                getIconData(noticias.icono),
                size: 24.0, // Puedes ajustar el tamaño según tus necesidades
              ),
            ),
          ),
          DataCell(
            Container(
              width: 80.0,
              child: Text(
                noticias.fechaPublicacion ?? 'N/A',
                style: TextStyle(fontSize: 10.0),
                maxLines: 20,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
        ],
      );
    }).toList();
  }
}
