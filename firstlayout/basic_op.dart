import 'package:flutter/material.dart';

void main() => runApp(const TextDisplay());

class TextDisplay extends StatelessWidget {
  const TextDisplay({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Declare two variables
    const double num1 = 8;
    const double num2 = 2;

    // Calculate the sum, difference, product, and quotient
    double sum = num1 + num2;
    double difference = num1 - num2;
    double product = num1 * num2;
    double quotient = num1 / num2;

    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Center(
            child: Text(
              'Basic Operations',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
          backgroundColor: Colors.blue,
        ),
        body: Center(
          child: Container(
            padding: const EdgeInsets.all(16.0),
            height: double.infinity, // Make the container 100% height
            width: double.infinity, // Make the container 100% width

            child: FractionallySizedBox(
              widthFactor: 0.5, // Set the width to 50% of the parent
              heightFactor: 1.0, // Set the height to 100% of the parent
              child: Container(
                decoration: BoxDecoration(
                  color:
                      Colors.white, // Blue background for the child container
                  border: Border.all(color: Colors.purple),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(
                        height: 16.0,
                      ), // Add some spacing between texts
                      Text(
                        'Sum: $sum',
                        style: const TextStyle(
                          fontSize: 16,
                          color: Colors.black,
                        ),
                      ),
                      Text(
                        'Difference: $difference',
                        style: const TextStyle(
                          fontSize: 16,
                          color: Colors.black,
                        ),
                      ),
                      Text(
                        'Product: $product',
                        style: const TextStyle(
                          fontSize: 16,
                          color: Colors.black,
                        ),
                      ),
                      Text(
                        'Quotient: $quotient',
                        style: const TextStyle(
                          fontSize: 16,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
        bottomNavigationBar: Container(
          color: Colors.blue,
          padding: const EdgeInsets.all(16.0),
          child: const Text(
            'Footer: Basic operation App',
            style: TextStyle(
              color: Colors.white,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
