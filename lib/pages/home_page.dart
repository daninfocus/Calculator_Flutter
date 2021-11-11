import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   toolbarHeight: 80,
      //   title: child: Text('Calculadora'),
      //   actions: [Icon(Icons.bluetooth)],
      // ),
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _cajaText(),
            _primeraFila(),
            _segundaFila(),
            _terceraFila(),
            _cuartaFila()
          ],
        ),
      ),
    );
  }

  Row _primeraFila() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _boton("7", () => null),
        _boton("8", () => null),
        _boton("9", () => null),
        _boton("+", () => null)
      ],
    );
  }

  Row _segundaFila() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _boton("4", () => null),
        _boton("5", () => null),
        _boton("6", () => null),
        _boton("-", () => null)
      ],
    );
  }

  Row _terceraFila() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _boton("1", () => null),
        _boton("2", () => null),
        _boton("3", () => null),
        _boton("*", () => null)
      ],
    );
  }

  Row _cuartaFila() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _boton('C', () => null),
        _boton('0', () => null),
        _boton('=', () => null),
        _boton('/', () => null),
      ],
    );
  }

  Widget _boton(String numero, Function() f) {
    return MaterialButton(
      height: 100,
      child: Text(numero,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 24.0)),
      textColor: Colors.grey,
      onPressed: f,
    );
  }

  Container _cajaText() {
    return Container(
      constraints: BoxConstraints.expand(height: 150),
      alignment: Alignment.bottomRight,
      color: Colors.white,
      child: Text(
        "0",
        style: TextStyle(fontSize: 50.0, color: Colors.black),
        textAlign: TextAlign.right,
      ),
    );
  }
}
