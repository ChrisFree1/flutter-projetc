// ignore_for_file: avoid_print

import 'dart:convert';

import 'package:http/http.dart' as http;

import '../Models/Books.dart';

class ServicesBooks {
  Future<List<Books>> getBooks() async {
    var url = 'https://15sl3cj3-3000.use.devtunnels.ms/books/getAllBooks';
    var response =
        await http.get(Uri.parse(url)).timeout(const Duration(seconds: 30));

    if (response.statusCode == 200) {
      var jsonString = response.body;
      var jsonData = jsonDecode(jsonString);
      List<Books> books = [];
      jsonData.forEach((value) {
        books.add(Books.fromJson(value));
      });
      return books;
    } else {
      throw Exception('Error al obtener los libros');
    }
  }

  Future<void> createBook(Books book) async {
    try {
      var url = 'https://15sl3cj3-3000.use.devtunnels.ms/books/createNewBooks';
      var newBooks = book.toJson();
      var response = await http.post(Uri.parse(url), body: newBooks);

      if (response.statusCode == 201) {
        print('Libro Creado Exitosamente');
      } else {
        throw Exception('Error al crear el libro');
      }
    } catch (error) {
      print('Error al crear el libro: $error');
    }
  }

  Future<void> deleteBook(String id_libro) async {
    try {
      var url =
          'https://15sl3cj3-3000.use.devtunnels.ms/books/deleteBook/$id_libro';
      var response = await http.delete(Uri.parse(url));

      if (response.statusCode == 200) {
        print('Libro Eliminado');
      } else {
        throw Exception(
            'Error al eliminar el libro: ${response.statusCode} ${response.reasonPhrase}');
      }
    } catch (error) {
      // Manejar cualquier error que ocurra durante la solicitud
      print('Error al eliminar el libro: $error');
      // No necesitas lanzar otra excepción aquí, ya que ya has manejado el error
    }
  }

  Future<void> updateBook(String idLibro, Books updatedBook) async {
    try {
      var url =
          'https://15sl3cj3-3000.use.devtunnels.ms/books/updateBook/$idLibro';
      var updatedBookJson = updatedBook.toJson();
      var response = await http.put(Uri.parse(url), body: updatedBookJson);

      if (response.statusCode == 200) {
        print('Libro actualizado exitosamente');
      } else {
        throw Exception(
            'Error al actualizar el libro: ${response.statusCode} ${response.reasonPhrase}');
      }
    } catch (error) {
      print('Error al actualizar el libro: $error');
    }
  }
}
