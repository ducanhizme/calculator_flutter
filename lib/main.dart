import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final buttons = [
    'C',
    '%',
    'DEL',
    '+',
    '7',
    '8',
    '9',
    '-',
    '4',
    '5',
    '6',
    '*',
    '1',
    '2',
    '3',
    '/',
    '0',
    '00',
    '.',
    '='
  ];
  String _output = '';
  double _num1 = 0;
  double _num2 = 0;
  String _operand = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      children: [
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.35,
          child: Container(
            alignment: Alignment.bottomRight,
            padding: const EdgeInsets.all(20),
            child: Text(
              _output,
              style: const TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
            ),
          ),
        ),
        const Divider(),
        Expanded(
          child: GridView.count(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              padding: EdgeInsets.zero,
              crossAxisCount: 4,
              children: buttons.map((e) => _buildButton(e)).toList()),
        )
      ],
    ));
  }

  _buttonPressed(String button) {
    setState(() {
      switch (button) {
        case 'C':
          _output = '';
          _num1 = 0;
          _num2 = 0;
          _operand = '';
          break;
        case 'DEL':
          _output = _output.isNotEmpty
              ? _output.substring(0, _output.length - 1)
              : '';
          break;
        case '+':
        case '-':
        case '*':
        case '/':
        case '%':
          _num1 = double.parse(_output);
          _operand = button;
          _output = '';
          break;
        case '=':
          _num2 = double.parse(_output);
          _output = _calculateResult(_num1, _num2, _operand);
          _num1 = 0;
          _num2 = 0;
          _operand = '';
          break;
        default:
          _output += button;
          break;
      }
    });
  }

  String _calculateResult(double num1, double num2, String operand) {
    switch (operand) {
      case '+':
        return (num1 + num2).toString();
      case '-':
        return (num1 - num2).toString();
      case '*':
        return (num1 * num2).toString();
      case '/':
        return (num1 / num2).toString();
      case '%':
        return (num1 % num2).toString();
      default:
        return '';
    }
  }

  Container _buildButton(String text) {
    return Container(
      margin: const EdgeInsets.all(2),
      child: ElevatedButton(
          onPressed: () {
            _buttonPressed(text);
          },
          style: ElevatedButton.styleFrom(
            shape: const BeveledRectangleBorder(),
          ),
          child: Text(
            text,
            style: const TextStyle(fontSize: 20, color: Colors.black),
          )),
    );
  }
}
