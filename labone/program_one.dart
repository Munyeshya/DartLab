import 'dart:io';

void main() {
  print("Enter Your first name:");
  String? fname = stdin.readLineSync();
  print("Enter Your last name:");
  String? lname = stdin.readLineSync();

  print("Enter the Age of a person:");
  int? age = int.parse(stdin.readLineSync()!);

  if (age >= 18) {
    print("Your full name is $fname $lname and You are voter.");
  } else {
    print("Your full name is $fname $lname and You are not voter.");
  }

  print("Enter the first number:");
  int? num1 = int.parse(stdin.readLineSync()!); //declaring number1
  print("Enter the second number:");
  int? num2 = int.parse(stdin.readLineSync()!);

  int sum = num1 + num2;
  int diff = num1 - num2;
  int mul = num1 * num2;
  double div = num1 / num2;
  String roundedDiv = div.toStringAsFixed(2);
  int div2 = num1 ~/ num2; // integer division
  int mod = num1 % num2;

  print("The sum is $sum");
  print("The diff is $diff");
  print("The mul is $mul");
  print("The div is $roundedDiv");
  print("The integer division is $div2.");
  print("The modulus is $mod.");

  stdout.write("Numbers from $num1 to $num2 are: ");
  for (int i = num1; i <= num2; i++) {
    stdout.write(" $i");
  }
}
