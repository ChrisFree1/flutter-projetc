// ignore_for_file: non_constant_identifier_names

class Books {
  String? id_libro;
  String? nombre_libro;
  String? autor_libro;
  String? fecha_publicacion;
  String? statusBook;

  Books(this.autor_libro, this.nombre_libro, this.fecha_publicacion);

  Books.fromJson(Map<String, dynamic> book) {
    id_libro = book['id_libro'];
    nombre_libro = book['nombre_libro'];
    autor_libro = book['autor_libro'];
    fecha_publicacion = book['fecha_publicacion'];
    statusBook = book['statusBook'];
  }

  Map<String, dynamic> toJson() {
    return {
      'nombre_libro': nombre_libro,
      'autor_libro': autor_libro,
      'fecha_publicacion': fecha_publicacion
    };
  }
}
