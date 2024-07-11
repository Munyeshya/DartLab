import 'package:flutter/material.dart';

void main() => runApp(const GreetingApp());

class GreetingApp extends StatelessWidget {
  const GreetingApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Center(
            child: Text('Greeting App'),
          ),
          backgroundColor: Colors.blue,
        ),
        body: const GreetingScreen(),
      ),
    );
  }
}

class GreetingScreen extends StatefulWidget {
  const GreetingScreen({Key? key}) : super(key: key);

  @override
  _GreetingScreenState createState() => _GreetingScreenState();
}

class _GreetingScreenState extends State<GreetingScreen> {
  final TextEditingController _controller = TextEditingController();
  String _greetingMessage = '';

  void _showGreeting() {
    setState(() {
      _greetingMessage = 'Hello, ${_controller.text}!';
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
            controller: _controller,
            decoration: const InputDecoration(
              labelText: 'Enter your name',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: _showGreeting,
            child: const Text('Greet Me'),
          ),
          const SizedBox(height: 20),
          Text(
            _greetingMessage,
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
