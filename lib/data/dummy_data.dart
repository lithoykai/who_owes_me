import 'package:who_owes_me/model/debtor.dart';

final dummy_Data = [
  Debtor(
    name: 'Leonardo',
    valueMouth: '25.00',
    number: '(81) 9952724432208',
    dateNow: DateTime.utc(2023, 02, 28), //NO FUTURO.
    datePay: DateTime.now().add(Duration(days: 30)),
  ),
  Debtor(
    name: 'Biro',
    valueMouth: '25.00',
    number: '(81) 995724208',
    dateNow: DateTime.now(),
    datePay: DateTime.now().add(Duration(days: 30)),
  ),
  Debtor(
    name: 'Luiz Henriqe',
    valueMouth: '25.00',
    number: '(81) 995724208',
    dateNow: DateTime.utc(2023, 01, 28), // NO FUTURO.
    datePay: DateTime.now().add(Duration(days: 30)),
  ),
];
