import 'package:flutter/material.dart';

void main() => runApp(const CalculatorApp());

class CalculatorApp extends StatelessWidget {
  const CalculatorApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Center(
            child: Text('Simple Calculator'),
          ),
          backgroundColor: Colors.blue,
        ),
        body: const CalculatorScreen(),
      ),
    );
  }
}

class CalculatorScreen extends StatefulWidget {
  const CalculatorScreen({Key? key}) : super(key: key);

  @override
  _CalculatorScreenState createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  final TextEditingController _controller1 = TextEditingController();
  final TextEditingController _controller2 = TextEditingController();
  String _result = '';

  void _calculate(String operation) {
    double num1 = double.tryParse(_controller1.text) ?? 0;
    double num2 = double.tryParse(_controller2.text) ?? 0;
    double res;

    switch (operation) {
      case 'add':
        res = num1 + num2;
        break;
      case 'subtract':
        res = num1 - num2;
        break;
      case 'multiply':
        res = num1 * num2;
        break;
      case 'divide':
        if (num2 != 0) {
          res = num1 / num2;
        } else {
          res = 0;
        }
        break;
      default:
        res = 0;
    }

    setState(() {
      _result = 'Result: $res';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextField(
            controller: _controller1,
            decoration: const InputDecoration(
              labelText: 'Enter first number',
              border: OutlineInputBorder(),
            ),
            keyboardType: TextInputType.number,
          ),
          const SizedBox(height: 20),
          TextField(
            controller: _controller2,
            decoration: const InputDecoration(
              labelText: 'Enter second number',
              border: OutlineInputBorder(),
            ),
            keyboardType: TextInputType.number,
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                onPressed: () => _calculate('add'),
                child: const Text('+'),
              ),
              ElevatedButton(
                onPressed: () => _calculate('subtract'),
                child: const Text('-'),
              ),
              ElevatedButton(
                onPressed: () => _calculate('multiply'),
                child: const Text('*'),
              ),
              ElevatedButton(
                onPressed: () => _calculate('divide'),
                child: const Text('/'),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Text(
            _result,
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
