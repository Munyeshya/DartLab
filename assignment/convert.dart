import 'package:flutter/material.dart';

void main() => runApp(const TemperatureConverterApp());

class TemperatureConverterApp extends StatelessWidget {
  const TemperatureConverterApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Temperature Converter'),
          centerTitle: true,
        ),
        body: const TemperatureConverterForm(),
      ),
    );
  }
}

class TemperatureConverterForm extends StatefulWidget {
  const TemperatureConverterForm({Key? key}) : super(key: key);

  @override
  _TemperatureConverterFormState createState() =>
      _TemperatureConverterFormState();
}

class _TemperatureConverterFormState extends State<TemperatureConverterForm> {
  final _formKey = GlobalKey<FormState>();
  final _temperatureController = TextEditingController();
  String _convertedTemperature = '';
  bool _isCelsius = true;

  void _convertTemperature() {
    if (_formKey.currentState?.validate() ?? false) {
      double inputTemperature = double.parse(_temperatureController.text);
      double convertedTemperature;

      if (_isCelsius) {
        convertedTemperature = (inputTemperature * 9 / 5) + 32;
        _convertedTemperature = '${convertedTemperature.toStringAsFixed(2)} °F';
      } else {
        convertedTemperature = (inputTemperature - 32) * 5 / 9;
        _convertedTemperature = '${convertedTemperature.toStringAsFixed(2)} °C';
      }

      setState(() {});
    }
  }

  void _toggleConversion() {
    setState(() {
      _isCelsius = !_isCelsius;
      _convertedTemperature = '';
      _temperatureController.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextFormField(
              controller: _temperatureController,
              decoration: InputDecoration(
                labelText: _isCelsius
                    ? 'Temperature in Celsius'
                    : 'Temperature in Fahrenheit',
                border: const OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter a temperature';
                }
                return null;
              },
            ),
            const SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: _convertTemperature,
              child: const Text('Convert'),
            ),
            const SizedBox(height: 16.0),
            Text(
              _convertedTemperature,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16.0),
            TextButton(
              onPressed: _toggleConversion,
              child: Text(
                _isCelsius
                    ? 'Switch to Fahrenheit to Celsius'
                    : 'Switch to Celsius to Fahrenheit',
                style: const TextStyle(color: Colors.blue),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
