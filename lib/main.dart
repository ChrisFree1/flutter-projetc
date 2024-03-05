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


  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Books>>(
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
                      Text('Estado: ${snapshot.data![index].statusBook ?? ''}'),
                    ],
                  ),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.edit),
                        onPressed: () {
                          // Agrega aquí la lógica para editar el libro
                        },
                      ),
                      IconButton(
                        icon: const Icon(Icons.delete),
                        onPressed: () {
                          // Agrega aquí la lógica para eliminar el libro
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
    );
  }
}
