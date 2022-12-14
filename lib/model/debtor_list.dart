import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:who_owes_me/data/dummy_data.dart';
import 'package:who_owes_me/utils/constants.dart';
import 'debtor.dart';

class DebtorList with ChangeNotifier {
  List<Debtor> _items = dummy_Data;

  List<Debtor> get items => [..._items];

  int get itemsCount {
    return _items.length;
  }

  Future<void> refreshDebtors() async {
    print(items.map((e) {
      if (e.dateNow.compareTo(e.datePay) == 1) {
        e.payment = Payment.atrasado;
      } else if (e.dateNow.compareTo(e.datePay) == -1) {
        return;
      } else {
        return;
      }
    }));
    notifyListeners();
  }

  void saveData(Map<String, Object> data, DateTime dataPay) {
    print(data['dataPay']);

    Payment payment = Payment.ok;
    if (DateTime.now().compareTo(data['dataPay'] as DateTime) == -1) {
      payment = Payment.ok;
    } else if (DateTime.now().compareTo(data['dataPay'] as DateTime) == 1) {
      payment = Payment.atrasado;
    }
    print(payment);

    final debtor = Debtor(
      valueMouth: data['valuePay'] as String,
      name: data['name'] as String,
      number: data['phoneNumber'] as String,
      dateNow: DateTime.now(),
      datePay: dataPay,
      payment: payment,
    );

    addData(debtor);
  }

  Future<void> addData(Debtor debtor) async {
    final response = await http.post(
      Uri.parse('${Constants.DEBTOR_URL}.json'),
      body: jsonEncode(
        {
          "name": debtor.name,
          "valuePay": debtor.valueMouth,
          "number": debtor.number,
          "dataPay": debtor.datePay.toIso8601String(),
          "dataAdd": DateTime.now().toIso8601String(),
          "payment": debtor.payment!.index,
        },
      ),
    );

    _items.add(
      Debtor(
        valueMouth: debtor.valueMouth,
        name: debtor.name,
        number: debtor.number,
        dateNow: debtor.dateNow,
        datePay: debtor.datePay,
      ),
    );
    refreshDebtors();
    notifyListeners();
  }
}
