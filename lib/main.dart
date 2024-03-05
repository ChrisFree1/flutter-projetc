// ignore_for_file: library_private_types_in_public_api, use_key_in_widget_constructors

import 'services/books.service.dart';
import 'package:flutter/material.dart';
import 'Models/Books.dart';
import 'pages/FormCreateBook.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    const appTitle = 'Listado de Libros';
    return MaterialApp(
      theme: ThemeData.dark(),
      title: appTitle,
      home: Scaffold(
        appBar: AppBar(
          title: const Text(appTitle),
        ),
        body: const MyCustomForm(),
        floatingActionButton: Builder(
          builder: (BuildContext context) {
            return FloatingActionButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const FormCreateBook()),
                );
              },
              child: const Icon(Icons.add),
            );
          },
        ),
      ),
    );
  }
}

class MyCustomForm extends StatefulWidget {
  const MyCustomForm({Key? key});

  @override
  _MyCustomFormState createState() => _MyCustomFormState();
}

class _MyCustomFormState extends State<MyCustomForm> {
  Future<void> _refresh() async {
    setState(() {});
  }

  Future<void> _deleteBook(String idLibro) async {
    try {
      await ServicesBooks().deleteBook(idLibro);
      await _refresh();
    } catch (error) {
      print('Error al eliminar el libro: $error');
    }
  }

  Future<void> _showDeleteConfirmationDialog(String? idLibro) async {
    if (idLibro != null) {
      return showDialog<void>(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Confirmar eliminación'),
            content: const SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  Text('¿Está seguro de que desea eliminar este libro?'),
                ],
              ),
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
                  Navigator.of(context).pop();
                  _deleteBook(idLibro);
                },
              ),
            ],
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: _refresh,
      child: FutureBuilder<List<Books>>(
        future: ServicesBooks().getBooks(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No hay libros disponibles'));
          } else {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                return Card(
                  child: ListTile(
                    leading: const Icon(Icons.library_books, size: 50),
                    title: Text(
                      snapshot.data![index].nombre_libro ?? '',
                      style: const TextStyle(
                          color: Color.fromARGB(255, 255, 255, 255)),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Autor: ${snapshot.data![index].autor_libro ?? ''}',
                          style: const TextStyle(
                              color: Color.fromARGB(255, 62, 109, 167)),
                        ),
                        Text(
                            'Fecha de publicación: ${snapshot.data![index].fecha_publicacion ?? ''}'),
                        Text(
                            'Estado: ${snapshot.data![index].statusBook ?? ''}'),
                      ],
                    ),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.edit),
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => FormCreateBook(
                                          bookToEdit: snapshot.data![index],
                                        )));
                          },
                        ),
                        IconButton(
                          icon: const Icon(Icons.delete),
                          onPressed: () {
                            _showDeleteConfirmationDialog(
                                snapshot.data![index].id_libro);
                          },
                          color: const Color.fromARGB(255, 243, 33, 33),
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
