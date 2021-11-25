import 'package:flutter/animation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:function_tree/function_tree.dart';
import 'package:intl/intl.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String _textResult = '';

  bool _hasDecimal = false;

  List<String> _operators = ['x', '+', '-', '/', '^', '%'];
  ScrollController _scrollController = ScrollController();
  TextEditingController _textController = TextEditingController(text: '');

  Map<String, String> _history = {};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        shadowColor: Colors.transparent,
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: Color(0xFF376952),
          systemNavigationBarColor: Colors.white,
        ),
      ),
      extendBodyBehindAppBar: true,
      body: SingleChildScrollView(
          controller: _scrollController,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _historyBox(),
              _cajaText(),
              _primeraFila(),
              _segundaFila(),
              _terceraFila(),
              _cuartaFila(),
              _quintaFila(),
            ],
          )),
    );
  }

  void hideHistory() {
    _scrollController.jumpTo(_scrollController.position.maxScrollExtent + 57);
  }

  Container _historyBox() {
    List<Widget> _lista = [];
    bool color = false;
    _lista.add(Container(
        color: Color(0xFF376952),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text('3x3+2',
              softWrap: false,
              style: TextStyle(
                  fontFamily: 'dotty',
                  fontSize: 60.0,
                  color: Colors.yellow.shade50,
                  overflow: TextOverflow.fade)),
        )));
    _history.forEach((key, item) {
      final entry = GestureDetector(
          onTap: () {
            setState(() {
              _textController.text = key;
              _textResult = item;
            });
          },
          child: Container(
              color: color ? Color(0xFF284A3A) : Color(0xFF3F5E4F),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text('$key=$item',
                    softWrap: false,
                    style: TextStyle(
                        fontFamily: 'dotty',
                        fontSize: 60.0,
                        color: Colors.yellow.shade50,
                        overflow: TextOverflow.fade)),
              )));

      color = !color;
      _lista.add(entry);
    });

    return Container(
      color: Color(0xFF284A3A),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: _lista,
      ),
    );
  }

  Row _primeraFila() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _boton(() => clearCharacters(),
            numero: 'AC',
            color: Colors.red.shade200,
            textColor: Colors.red.shade900,
            width: 180),

        // _boton(() => appendCharacters('%'),
        //     numero: '%',
        //     color: Colors.green.shade100,
        //     textColor: Colors.grey.shade800),
        _boton(() => appendCharacters('^'),
            numero: '^',
            color: Colors.green.shade100,
            textColor: Colors.grey.shade800),
        _boton(() => appendCharacters('/'),
            icono: Icon(CupertinoIcons.divide),
            color: Colors.green.shade100,
            textColor: Colors.grey.shade800),
      ],
    );
  }

  Row _segundaFila() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _boton(() => appendCharacters('7'),
            numero: '7', color: Colors.grey.shade800),
        _boton(() => appendCharacters('8'),
            numero: '8', color: Colors.grey.shade800),
        _boton(() => appendCharacters('9'),
            numero: '9', color: Colors.grey.shade800),
        _boton(() => appendCharacters('x'),
            icono: Icon(CupertinoIcons.multiply),
            color: Colors.green.shade100,
            textColor: Colors.grey.shade800),
      ],
    );
  }

  Row _terceraFila() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _boton(() => appendCharacters('4'),
            numero: '4', color: Colors.grey.shade800),
        _boton(() => appendCharacters('5'),
            numero: '5', color: Colors.grey.shade800),
        _boton(() => appendCharacters('6'),
            numero: '6', color: Colors.grey.shade800),
        _boton(() => appendCharacters('-'),
            icono: Icon(CupertinoIcons.minus),
            color: Colors.green.shade100,
            textColor: Colors.grey.shade800),
      ],
    );
  }

  Row _cuartaFila() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _boton(() => appendCharacters('1'),
            numero: '1', color: Colors.grey.shade800),
        _boton(() => appendCharacters('2'),
            numero: '2', color: Colors.grey.shade800),
        _boton(() => appendCharacters('3'),
            numero: '3', color: Colors.grey.shade800),
        _boton(() => appendCharacters('+'),
            icono: Icon(CupertinoIcons.add),
            color: Colors.green.shade100,
            textColor: Colors.grey.shade800),
      ],
    );
  }

  Row _quintaFila() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _boton(() => appendCharacters('0'),
            numero: '0', color: Colors.grey.shade800),
        _boton(() => appendDecimal('.'),
            numero: '.', color: Colors.grey.shade800),
        _boton(() => deleteCharacter(),
            icono: const Icon(CupertinoIcons.delete_left),
            color: Colors.grey.shade800),
        _boton(() => setResult(_textController.text),
            numero: '=',
            color: Colors.greenAccent,
            textColor: Colors.grey.shade800),
      ],
    );
  }

  void clearCharacters() {
    var newValue = _textController.value.copyWith(
        text: '',
        selection: TextSelection.fromPosition(TextPosition(offset: 0)));
    _hasDecimal = false;
    _textController.value = newValue;
    _textResult = '';
    setState(() {});
  }

  void deleteCharacter() {
    var cursorPos = _textController.selection.base.offset;
    String oldText = _textController.text;

    //Left text of cursor position
    String suffixText = _textController.text.substring(0, cursorPos - 1);

    //Char to delete
    String charDel = _textController.text.substring(cursorPos - 1, cursorPos);
    if (charDel == '.') {
      _hasDecimal = false;
    }
    //Right text of cursor
    String lastChunk = oldText.substring(cursorPos, oldText.length);

    var newValue = _textController.value.copyWith(
        text: suffixText + lastChunk,
        selection:
            TextSelection.fromPosition(TextPosition(offset: cursorPos - 1)));
    _textController.value = newValue;
  }

  void appendDecimal(String decimal) {
    if (!_hasDecimal) {
      _hasDecimal = true;
      var cursorPos = _textController.selection.base.offset;
      String oldText = _textController.text;
      String newText = oldText + decimal;

      //Left text of cursor position
      String suffixText = _textController.text.substring(0, cursorPos);

      //Right text of cursor
      String lastChunk = oldText.substring(cursorPos, oldText.length);

      var newValue = _textController.value.copyWith(
          text: suffixText + decimal + lastChunk,
          selection:
              TextSelection.fromPosition(TextPosition(offset: cursorPos + 1)));

      _textController.value = newValue;
    }
  }

  void appendCharacters(String value) {
    String wholeText = _textController.text;
    var cursorPos = _textController.selection.base.offset;
    if (cursorPos == -1) {
      cursorPos = 0;
    }

    String newText = wholeText + value;

    //Left text of cursor position
    String suffixText = _textController.text.substring(0, cursorPos);

    //Right text of cursor
    String lastChunk = wholeText.substring(cursorPos, wholeText.length);

    var newValue = _textController.value.copyWith(
        text: suffixText + value + lastChunk,
        selection:
            TextSelection.fromPosition(TextPosition(offset: cursorPos + 1)));
    _textController.value = newValue;
  }

  void setResult(String currNumbers) {
    hideHistory();
    if (currNumbers.length > 0) {
      var operatorPos = -1;

      var text = _textController.text;

      while (text.indexOf('x') != -1) {
        text = text.replaceRange(text.indexOf('x'), text.indexOf('x') + 1, '*');
      }

      num resultDouble = text.interpret();
      print(resultDouble);
      var formatter = NumberFormat('###,###,###,###.###############');
      String resultFinal = formatter.format(resultDouble);

      setState(() {
        hideHistory();
        _history[text] = resultFinal;
        _textResult = resultFinal;
      });
    }
  }

  Widget _boton(Function() f,
      {String? numero,
      Icon? icono,
      Color? color,
      Color? textColor,
      double width = 90}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.5),
      child: ClipRRect(
        borderRadius: const BorderRadius.all(Radius.circular(90)),
        child: MaterialButton(
          height: 90,
          minWidth: width,
          child: numero != null
              ? Text(numero,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 24.0))
              : icono,
          textColor: textColor == null ? Colors.grey.shade300 : textColor,
          color: color,
          onPressed: f,
        ),
      ),
    );
  }

  Container _cajaText() {
    return Container(
      decoration: BoxDecoration(
          color: Color(0xFF376952),
          borderRadius: BorderRadius.vertical(bottom: Radius.circular(25))),
      height: 250,
      child:
          Column(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        const SizedBox(
          height: 50,
        ),
        _inputField(),
        _resultText(),
        Divider(
          color: Colors.yellow.shade200,
          height: 10,
          thickness: 4,
          indent: 170,
          endIndent: 170,
        ),
      ]),
    );
  }

  Container _inputField() {
    return Container(
        height: 100,
        width: MediaQuery.of(context).size.width - 15,
        child: TextField(
          keyboardType: TextInputType.number,
          maxLines: 1,
          cursorColor: Colors.black,
          showCursor: true,
          readOnly: true,
          style: TextStyle(
              fontFamily: 'digital7',
              fontSize: 100.0,
              color: Colors.yellow.shade50),
          controller: _textController,
          decoration: const InputDecoration.collapsed(hintText: 'Webb TI-84'),
        ));
  }

  Expanded _resultText() {
    return Expanded(
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Text(
          _textResult,
          style: TextStyle(
              fontFamily: 'digital7', fontSize: 60, color: Colors.black54),
        ),
      ),
    );
  }
}
