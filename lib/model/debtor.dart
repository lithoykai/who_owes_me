import 'package:flutter/material.dart';

class Debtor with ChangeNotifier {
  String name;
  String number;
  String valueMouth;
  DateTime dateNow;
  DateTime datePay;
  Payment? payment;

  Debtor({
    this.payment,
    required this.valueMouth,
    required this.name,
    required this.number,
    required this.dateNow,
    required this.datePay,
  });

  Color? get paymentColor {
    switch (payment) {
      case Payment.ok:
        return Colors.white;
      case Payment.atrasado:
        return Color.fromARGB(118, 229, 115, 115);
      default:
        return Colors.white;
    }
  }
}

enum Payment { ok, atrasado }
