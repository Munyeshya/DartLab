// lib/screens/body_health_status_page.dart
import 'package:flutter/material.dart';
import 'bmi_check_page.dart';
import 'login_page.dart';

class BodyHealthStatusPage extends StatefulWidget {
  @override
  _BodyHealthStatusPageState createState() => _BodyHealthStatusPageState();
}

class _BodyHealthStatusPageState extends State<BodyHealthStatusPage> {
  final TextEditingController _temperatureController = TextEditingController();
  final TextEditingController _bpmController = TextEditingController();

  void _checkHealthStatus() {
    final double temperature =
        double.tryParse(_temperatureController.text) ?? 0;
    final int bpm = int.tryParse(_bpmController.text) ?? 0;
    String message;

    if ((temperature >= 36.5 && temperature <= 37.5) &&
        (bpm >= 60 && bpm <= 100)) {
      message = 'Normal';
    } else {
      message = 'Sorry, please visit a healthcare provider.';
    }

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  void _logout() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => LoginPage()),
    );
  }

  void _navigateToBmiCheck() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => BmiCheckPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Body Health Status'),
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
              controller: _temperatureController,
              decoration: InputDecoration(labelText: 'Body Temperature (°C)'),
              keyboardType: TextInputType.number,
            ),
            TextField(
              controller: _bpmController,
              decoration: InputDecoration(labelText: 'BPM'),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _checkHealthStatus,
              child: Text('Check Health Status'),
            ),
            TextButton(
              onPressed: _navigateToBmiCheck,
              child: Text('BMI Check'),
            ),
          ],
        ),
      ),
    );
  }
}
