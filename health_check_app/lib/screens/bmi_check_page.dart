// lib/screens/bmi_check_page.dart
import 'package:flutter/material.dart';
import 'body_health_status_page.dart';
import 'login_page.dart';

class BmiCheckPage extends StatefulWidget {
  @override
  _BmiCheckPageState createState() => _BmiCheckPageState();
}

class _BmiCheckPageState extends State<BmiCheckPage> {
  final TextEditingController _heightController = TextEditingController();
  final TextEditingController _weightController = TextEditingController();
  String _bmiResult = '';

  void _calculateBmi() {
    final double height = double.tryParse(_heightController.text) ?? 0;
    final double weight = double.tryParse(_weightController.text) ?? 0;

    if (height > 0 && weight > 0) {
      final double bmi = weight / (height * height);
      setState(() {
        _bmiResult = 'BMI: ${bmi.toStringAsFixed(2)}';
      });
    } else {
      setState(() {
        _bmiResult = 'Please enter valid values';
      });
    }
  }

  void _logout() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => LoginPage()),
    );
  }

  void _goBack() {
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('BMI Check'),
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: _logout,
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _heightController,
              decoration: InputDecoration(labelText: 'Height (m)'),
              keyboardType: TextInputType.number,
            ),
            TextField(
              controller: _weightController,
              decoration: InputDecoration(labelText: 'Weight (kg)'),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _calculateBmi,
              child: Text('Calculate BMI'),
            ),
            SizedBox(height: 20),
            Text(
              _bmiResult,
              style: TextStyle(fontSize: 20),
            ),
            TextButton(
              onPressed: _goBack,
              child: Text('Back'),
            ),
          ],
        ),
      ),
    );
  }
}
