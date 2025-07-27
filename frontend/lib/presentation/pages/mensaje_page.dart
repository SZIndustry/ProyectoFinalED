import 'package:flutter/material.dart';
import 'pagina1.dart';
import 'pagina2.dart';
import 'pagina3.dart';

class MensajePage extends StatelessWidget {
  Widget buildButton(BuildContext context, String label, IconData icon, Widget destino) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: ElevatedButton.icon(
        icon: Icon(icon, size: 28),
        label: Text(
          label,
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        style: ElevatedButton.styleFrom(
          minimumSize: Size(220, 60),
          primary: Colors.indigo, // color de fondo
          onPrimary: Colors.white, // color del texto
          elevation: 8, // sombra
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
        ),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => destino),
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF1F3F4),
      appBar: AppBar(
        title: Text('Proyecto Final de ED'),
        backgroundColor: Colors.indigo,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            buildButton(context, 'Maze', Icons.grid_view, Pagina1()),
            buildButton(context, 'Datos', Icons.bar_chart, Pagina2()),
            buildButton(context, 'Benchmarking', Icons.timeline, Pagina3()),
          ],
        ),
      ),
    );
  }
}
