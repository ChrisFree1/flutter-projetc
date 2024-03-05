// ignore_for_file: library_private_types_in_public_api, use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_material_pickers/flutter_material_pickers.dart';
import '../services/books.service.dart';
import '../Models/Books.dart';

class FormCreateBook extends StatefulWidget {
  final Books? bookToEdit;

  const FormCreateBook({super.key, this.bookToEdit});

  @override
  _FormCreateBookState createState() => _FormCreateBookState();
}

class _FormCreateBookState extends State<FormCreateBook> {
  void _selectDate(BuildContext context) {
    showMaterialDatePicker(
      context: context,
      selectedDate: _selectedDate,
      onChanged: (value) => setState(() => _selectedDate = value),
      firstDate: DateTime(1600),
      lastDate: DateTime.now(),
    );
  }

  @override
  void initState() {
    super.initState();
    if (widget.bookToEdit != null) {
      _nombreLibroController.text = widget.bookToEdit!.nombre_libro ?? '';
      _autorLibroController.text = widget.bookToEdit!.autor_libro ?? '';
      _selectedDate =
          DateTime.parse(widget.bookToEdit!.fecha_publicacion ?? '');
    }
  }

  final _formState = GlobalKey<FormState>();
  DateTime _selectedDate = DateTime.now();
  final _serviceBooks = ServicesBooks();

  final _nombreLibroController = TextEditingController();
  final _autorLibroController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Crear Libro'),
      ),
      body: Form(
        key: _formState,
        child: Column(
          children: <Widget>[
            TextFormField(
              controller: _nombreLibroController,
              decoration: const InputDecoration(
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 17, vertical: 20),
                  border: OutlineInputBorder(),
                  hintText: 'Nombre Libro'),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Por favor ingresa un valor';
                }
                return null;
              },
            ),
            const SizedBox(height: 20, width: 10),
            TextFormField(
              controller: _autorLibroController,
              decoration: const InputDecoration(
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 17, vertical: 20),
                  border: OutlineInputBorder(),
                  hintText: 'Nombre Autor'),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Por favor ingresa un valor';
                }
                return null;
              },
            ),
            const SizedBox(height: 20, width: 10),
            GestureDetector(
              onTap: () {
                _selectDate(context);
              },
              child: AbsorbPointer(
                child: TextFormField(
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Fecha de Publicación',
                      contentPadding:
                          EdgeInsets.symmetric(horizontal: 10, vertical: 20)),
                  controller: TextEditingController(
                      text: _selectedDate
                          .toString()), // Muestra la fecha seleccionada
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor selecciona una fecha';
                    }
                    return null;
                  },
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                if (_formState.currentState!.validate()) {
                  final newBook = Books(
                    _autorLibroController.text,
                    _nombreLibroController.text,
                    _selectedDate.toString(),
                  );
                  if (widget.bookToEdit != null) {
                    // Lógica para actualizar el libro
                    _serviceBooks
                        .updateBook(widget.bookToEdit!.id_libro!, newBook)
                        .then((_) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Libro actualizado')),
                      );
                      // Restablecer el formulario
                      _nombreLibroController.clear();
                      _autorLibroController.clear();
                      setState(() {
                        _selectedDate = DateTime.now();
                      });
                    }).catchError((error) {
                      // Mostrar un mensaje de error si falla la actualización del libro
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Error al actualizar el libro'),
                          backgroundColor: Color.fromARGB(255, 43, 189, 182),
                        ),
                      );
                    });
                  } else {
                    // Lógica para crear un nuevo libro
                    _serviceBooks.createBook(newBook).then((_) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Libro creado')),
                      );
                      // Restablecer el formulario
                      _nombreLibroController.clear();
                      _autorLibroController.clear();
                      setState(() {
                        _selectedDate = DateTime.now();
                      });
                    }).catchError((error) {
                      // Mostrar un mensaje de error si falla la creación del libro
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Error al crear el libro'),
                          backgroundColor: Color.fromARGB(255, 43, 189, 182),
                        ),
                      );
                    });
                  }
                }
              },
              child: Text(widget.bookToEdit != null
                  ? 'Actualizar Libro'
                  : 'Crear Libro'),
            ),
          ],
        ),
      ),
    );
  }
}
