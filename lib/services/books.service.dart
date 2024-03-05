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
    var url = 'https://15sl3cj3-3000.use.devtunnels.ms/books/createNewBooks';
    var newBooks = book.toJson();
    var response = await http.post(Uri.parse(url), body: newBooks);

    if (response.statusCode == 201) {
      print('Libro Creado Exitosamente');
    } else {
      throw Exception('Error al crear el libro');
    }
  }
}
