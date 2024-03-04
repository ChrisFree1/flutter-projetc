import 'package:flutter/material.dart';

//Creando una interfaz para formulario

class FormCreateBook extends StatefulWidget {
  const FormCreateBook({super.key});

  @override
  FormCreateBookState createState() {
    return FormCreateBookState();
  }
}

class FormCreateBookState extends State<FormCreateBook> {
  final _formState = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Form(
        key: _formState,
        child: Column(
          children: <Widget>[
            TextFormField(
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Por favor ingresa un valor';
                }
                return null;
              },
            ),
            ElevatedButton(
                onPressed: () {
                  if (_formState.currentState!.validate()) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Libro Creado'))
                    );
                  }
                },
                child: const Text('Crear Libro'))
          ],
        ));
  }
}
