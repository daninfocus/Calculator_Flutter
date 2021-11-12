import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController _textController = TextEditingController(text: '');
  bool hasDecimal = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        shadowColor: Colors.transparent,
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: Color(0xFF022B14),
          systemNavigationBarColor: Colors.white,
        ),
      ),
      body: Container(
        color: Colors.black54,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _cajaText(),
            _primeraFila(),
            _segundaFila(),
            _terceraFila(),
            _cuartaFila(),
            _quintaFila()
          ],
        ),
      ),
    );
  }

  Row _primeraFila() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _boton(() => null, numero: 'AC'),
        _boton(() => null, numero: '()'),
        _boton(() => null, icono: Icon(CupertinoIcons.percent)),
        _boton(() => null, icono: Icon(CupertinoIcons.divide)),
      ],
    );
  }

  Row _segundaFila() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _boton(() => appendCharacters('7'), numero: '7'),
        _boton(() => appendCharacters('8'), numero: '8'),
        _boton(() => appendCharacters('9'), numero: '9'),
        _boton(() => null, icono: Icon(CupertinoIcons.multiply)),
      ],
    );
  }

  Row _terceraFila() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _boton(() => appendCharacters('4'), numero: '4'),
        _boton(() => appendCharacters('5'), numero: '5'),
        _boton(() => appendCharacters('6'), numero: '6'),
        _boton(() => null, icono: Icon(CupertinoIcons.minus)),
      ],
    );
  }

  Row _cuartaFila() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _boton(() => appendCharacters('1'), numero: '1'),
        _boton(() => appendCharacters('2'), numero: '2'),
        _boton(() => appendCharacters('3'), numero: '3'),
        _boton(() => null, icono: Icon(CupertinoIcons.add)),
      ],
    );
  }

  Row _quintaFila() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _boton(() => appendCharacters('0'), numero: '0'),
        _boton(() => appendDecimal('.'), numero: '.'),
        _boton(() => deleteCharacter(),
            icono: const Icon(CupertinoIcons.delete_left)),
        _boton(() => appendCharacters('='), numero: '='),
      ],
    );
  }

  void deleteCharacter() {
    var cursorPos = _textController.selection.base.offset;
    print(cursorPos);

    //Right text of cursor position
    //String suffixText = _textController.text.substring(cursorPos);
    //print(suffixText);
    // Add new text on cursor position
    //String specialChars = ' text_1 ';
    //int length = specialChars.length;

    //Get the left text of cursor
    //String prefixText = _textController.text.substring(0, cursorPos);

    //_textController.text = prefixText + specialChars + suffixText;

    // Cursor move to end of added text
    //_textController.selection = TextSelection(
    //  baseOffset: cursorPos + length,
    //  extentOffset: cursorPos + length,
    //);
    //String oldText = _textController.text;
    // String firstChunk =
    //     oldText.substring(0, _textController.selection.extentOffset);
    //print(_textController.selection.start);
    // String lastChunk = oldText.substring(
    //     _textController.selection.extentOffset, oldText.length);
    //print(oldText);
    //var newValue = _textController.value.copyWith(
    //    text: oldText,
    //    selection:
    //        TextSelection.fromPosition(TextPosition(offset: oldText.length)));
    //_textController.value = newValue;
  }

  void appendDecimal(String decimal) {
    if (!hasDecimal) {
      hasDecimal = true;
      String oldText = _textController.text;
      String newText = oldText + decimal;

      var newValue = _textController.value.copyWith(
          text: newText,
          selection:
              TextSelection.fromPosition(TextPosition(offset: newText.length)));

      _textController.value = newValue;
    }
  }

  void appendCharacters(String value) {
    String oldText = _textController.text;
    String newText = oldText + value;

    var newValue = _textController.value.copyWith(
        text: newText,
        selection:
            TextSelection.fromPosition(TextPosition(offset: newText.length)));

    _textController.value = newValue;
  }

  Widget _boton(Function() f, {String? numero, Icon? icono}) {
    return ClipRRect(
      borderRadius: const BorderRadius.all(Radius.circular(90)),
      child: MaterialButton(
        height: 80,
        minWidth: 80,
        child: numero != null
            ? Text(numero,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24.0))
            : icono,
        textColor: Colors.grey,
        onPressed: f,
      ),
    );
  }

  Container _cajaText() {
    return Container(
        decoration: const BoxDecoration(
            color: Color(0xFF022B14),
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(25),
                bottomRight: Radius.circular(25))),
        alignment: Alignment.bottomRight,
        //color: Colors.white,
        height: 250,
        child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: TextField(
                        //keyboardType: TextInputType.number,
                        cursorColor: Colors.white,
                        showCursor: true,
                        readOnly: true,
                        style: const TextStyle(
                          fontSize: 40.0,
                          height: 2.0,
                        ),
                        controller: _textController,
                        decoration: InputDecoration.collapsed(hintText: ''),
                      )),
                ],
              ),
              ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(5)),
                child: Divider(
                  color: Colors.blueGrey,
                  height: 40,
                  thickness: 4,
                  indent: 170,
                  endIndent: 170,
                ),
              ),
            ]));
  }
}
