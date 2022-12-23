import 'package:flutter/material.dart';

class Debtor with ChangeNotifier {
  String? id;
  String name;
  String number;
  String valuePay;
  DateTime datePay;
  Payment? payment;

  Debtor({
    this.id,
    this.payment,
    required this.valuePay,
    required this.name,
    required this.number,
    required this.datePay,
  });

  Color? get paymentColor {
    switch (payment) {
      case Payment.ok:
        return Colors.white;
      case Payment.atrasado:
        return const Color.fromARGB(118, 229, 115, 115);
      default:
        return Colors.white;
    }
  }
}

enum Payment { ok, atrasado }
