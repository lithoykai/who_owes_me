import 'dart:convert';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:who_owes_me/utils/constants.dart';
import 'debtor.dart';

class DebtorList with ChangeNotifier {
  List<Debtor> _items = [];

  List<Debtor> get items => [..._items];

  int get itemsCount {
    return _items.length;
  }

  Future<void> checkDebtorPayments() async {
    final response = await http.get(Uri.parse('${Constants.DEBTOR_URL}.json'));
    if (response.body == 'null') return;

    Map<String, dynamic> data = jsonDecode(response.body);
    data.forEach((id, debtorData) {
      DateTime datePay = DateTime.parse(debtorData['datePay']);
      if (DateTime.now().compareTo(datePay) == 1) {
        http.patch(Uri.parse('${Constants.DEBTOR_URL}/$id.json'),
            body: jsonEncode({"payment": 1}));
      } else if (DateTime.now().compareTo(datePay) == -1) {
        http.patch(Uri.parse('${Constants.DEBTOR_URL}/$id.json'),
            body: jsonEncode({"payment": 0}));
      }
    });
  }

  Future<void> paymentDone(Debtor debtor) async {
    final response = await http.get(Uri.parse('${Constants.DEBTOR_URL}.json'));
    if (response.body == 'null') return;
    Map<String, dynamic> data = jsonDecode(response.body);

    int index = _items.indexWhere((p) => p.id == debtor.id);

    if (index >= 0) {
      await http.patch(
        Uri.parse(
          '${Constants.DEBTOR_URL}/${debtor.id}.json',
        ),
        body: jsonEncode({
          "datePay": debtor.datePay.add(Duration(days: 30)).toIso8601String(),
          "payment": 0,
        }),
      );
    }
  }

  Future<void> listDebtors() async {
    _items.clear();

    final response = await http.get(Uri.parse('${Constants.DEBTOR_URL}.json'));
    if (response.body == 'null') return;
    Map<String, dynamic> data = jsonDecode(response.body);
    await checkDebtorPayments();

    data.forEach((id, debtorData) {
      _items.add(
        Debtor(
            id: id,
            payment: Payment.values.elementAt(debtorData['payment']),
            valuePay: debtorData['valuePay'],
            name: debtorData['name'],
            number: debtorData['number'],
            datePay: DateTime.parse(debtorData['datePay'])),
      );
    });

    notifyListeners();
  }

  Future<void> refreshDebtors() async {
    print(items.map((e) {
      print(DateTime.now().compareTo(e.datePay));
      if (DateTime.now().compareTo(e.datePay) == 1) {
        e.payment = Payment.atrasado;
      } else if (DateTime.now().compareTo(e.datePay) == 0) {
        e.payment = Payment.ok;
        ;
      } else {
        return;
      }
    }));
    notifyListeners();
  }

  void saveData(Map<String, Object> data, DateTime datePay) {
    Payment payment = Payment.ok;
    if (DateTime.now().compareTo(data['datePay'] as DateTime) == -1) {
      payment = Payment.ok;
    } else if (DateTime.now().compareTo(data['datePay'] as DateTime) == 1) {
      payment = Payment.atrasado;
    }

    final debtor = Debtor(
      valuePay: data['valuePay'] as String,
      name: data['name'] as String,
      number: data['phoneNumber'] as String,
      datePay: datePay,
      payment: payment,
    );
    // listDebtors();
    addData(debtor);
  }

  Payment checkPayment(Debtor debtor) {
    Payment payment = Payment.ok;
    if (DateTime.now().compareTo(debtor.datePay as DateTime) == -1) {
      return payment = Payment.ok;
    } else if (DateTime.now().compareTo(debtor.datePay as DateTime) == 1) {
      return payment = Payment.atrasado;
    }
    return payment;
  }

  Future<void> addData(Debtor debtor) async {
    Payment payment = checkPayment(debtor);
    final response = await http.post(
      Uri.parse('${Constants.DEBTOR_URL}.json'),
      body: jsonEncode(
        {
          "name": debtor.name,
          "valuePay": debtor.valuePay,
          "number": debtor.number,
          "datePay": debtor.datePay.toIso8601String(),
          "dateAdd": DateTime.now().toIso8601String(),
          "payment": debtor.payment!.index,
        },
      ),
    );
    final id = jsonDecode(response.body)['number'];
    print(id);
    _items.add(
      Debtor(
        valuePay: debtor.valuePay,
        name: debtor.name,
        number: debtor.number,
        datePay: debtor.datePay,
      ),
    );

    notifyListeners();
  }
}
