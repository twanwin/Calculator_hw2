import 'package:flutter/material.dart';

void main() {
  runApp(CalculatorApp());
}

class CalculatorApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Calculator',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        brightness: Brightness.dark,
      ),
      debugShowCheckedModeBanner: false,
      home: CalculatorHomePage(),
    );
  }
}

class CalculatorHomePage extends StatefulWidget {
  @override
  _CalculatorHomePageState createState() => _CalculatorHomePageState();
}

class _CalculatorHomePageState extends State<CalculatorHomePage> {
  String _output = "0";
  String _input = "";
  double _num1 = 0;
  double _num2 = 0;
  String _operand = "";

  void _buttonPressed(String buttonText) {
    if (buttonText == "C") {
      _input = "";
      _output = "0";
      _num1 = 0;
      _num2 = 0;
      _operand = "";
    } else if (buttonText == "+" ||
        buttonText == "-" ||
        buttonText == "*" ||
        buttonText == "/") {
      _num1 = double.parse(_input);
      _operand = buttonText;
      _input = "";
    } else if (buttonText == ".") {
      if (_input.contains(".")) {
        return;
      } else {
        _input = _input + buttonText;
      }
    } else if (buttonText == "=") {
      _num2 = double.parse(_input);

      switch (_operand) {
        case "+":
          _output = (_num1 + _num2).toString();
          break;
        case "-":
          _output = (_num1 - _num2).toString();
          break;
        case "*":
          _output = (_num1 * _num2).toString();
          break;
        case "/":
          _output = _num2 == 0 ? "Error" : (_num1 / _num2).toString();
          break;
      }

      _input = _output;
      _operand = "";
    } else {
      _input = _input + buttonText;
    }

    setState(() {
      _output = double.tryParse(_input)?.toStringAsFixed(2) ?? _input;
    });
  }

  Widget _buildButton(String buttonText, Color color) {
    return Expanded(
      child: Container(
        margin: EdgeInsets.all(8.0),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            padding: EdgeInsets.all(20.0),
            backgroundColor: color,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.0),
            ),
          ),
          child: Text(
            buttonText,
            style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
          ),
          onPressed: () => _buttonPressed(buttonText),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text('Calculator'),
        backgroundColor: Colors.blueGrey[900],
      ),
      body: Column(
        children: <Widget>[
          Container(
            alignment: Alignment.centerRight,
            padding: EdgeInsets.symmetric(vertical: 24, horizontal: 12),
            child: Text(
              _output,
              style: TextStyle(
                fontSize: 48.0,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
          Expanded(
            child: Divider(),
          ),
          Column(
            children: [
              Row(
                children: <Widget>[
                  _buildButton("7", Colors.blueGrey[800]!),
                  _buildButton("8", Colors.blueGrey[800]!),
                  _buildButton("9", Colors.blueGrey[800]!),
                  _buildButton("/", Colors.deepOrange),
                ],
              ),
              Row(
                children: <Widget>[
                  _buildButton("4", Colors.blueGrey[800]!),
                  _buildButton("5", Colors.blueGrey[800]!),
                  _buildButton("6", Colors.blueGrey[800]!),
                  _buildButton("*", Colors.deepOrange),
                ],
              ),
              Row(
                children: <Widget>[
                  _buildButton("1", Colors.blueGrey[800]!),
                  _buildButton("2", Colors.blueGrey[800]!),
                  _buildButton("3", Colors.blueGrey[800]!),
                  _buildButton("-", Colors.deepOrange),
                ],
              ),
              Row(
                children: <Widget>[
                  _buildButton(".", Colors.blueGrey[800]!),
                  _buildButton("0", Colors.blueGrey[800]!),
                  _buildButton("C", Colors.blueGrey[800]!),
                  _buildButton("+", Colors.deepOrange),
                ],
              ),
              Row(
                children: <Widget>[
                  _buildButton("=", Colors.orange),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
