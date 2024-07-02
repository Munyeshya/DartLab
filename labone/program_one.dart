import 'dart:io';

void main() {
  var fname = "Munyeshya";
  var lname = "Beni Obed";
  print("My full name is $fname $lname");
  print('Enter the first number:');

  print("Enter the first number:");
  int? num1 = int.parse(stdin.readLineSync()!); //declaring number1
  print("Enter the second number:");
  int? num2 = int.parse(stdin.readLineSync()!);
  print("Enter the Age of a person:");
  int? age = int.parse(stdin.readLineSync()!);

  int sum = num1 + num2;
  int diff = num1 - num2;
  int mul = num1 * num2;
  double div = num1 / num2;
  String roundedDiv = div.toStringAsFixed(2);
  int div2 = num1 ~/ num2; // integer division
  int mod = num1 % num2;

  if (age >= 18) {
    print("You are voter.");
  } else {
    print("You are not voter.");
  }

  print("The sum is $sum");
  print("The diff is $diff");
  print("The mul is $mul");
  print("The div is $roundedDiv");
  print("The integer division is $div2.");
  print("The modulus is $mod.");

  for (int i = 1; i <= 10; i++) {
    print(i);
  }
}
