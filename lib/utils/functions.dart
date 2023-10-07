import 'dart:math';

String randomid() {
  int minLength=10;
  final random = Random();
  String randomNumber = '';

  while (randomNumber.length < minLength) {
    randomNumber += random.nextInt(10).toString();
  }

  return randomNumber;
}

