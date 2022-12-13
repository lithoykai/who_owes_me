import 'package:flutter/cupertino.dart';
import 'package:who_owes_me/data/dummy_data.dart';

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
    final debtor = Debtor(
      valueMouth: data['valuePay'] as String,
      name: data['name'] as String,
      number: data['phoneNumber'] as String,
      dateNow: DateTime.now(),
      datePay: dataPay,
    );

    addData(debtor);
  }

  void addData(Debtor debtor) {
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
