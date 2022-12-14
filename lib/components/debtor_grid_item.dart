import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../model/debtor.dart';
import '../model/debtor_list.dart';

class DebtorGridItem extends StatefulWidget {
  @override
  State<DebtorGridItem> createState() => _DebtorGridItemState();
}

class _DebtorGridItemState extends State<DebtorGridItem> {
  // Debtor debtor;
  @override
  Widget build(BuildContext context) {
    final debtor = Provider.of<Debtor>(
      context,
      listen: false,
    );
    return ListTile(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(5),
      ),
      tileColor: debtor.paymentColor!,
      title: Text(debtor.name),
      subtitle: Text('${debtor.number} - R\$ ${debtor.valueMouth}'),
      trailing: Column(
        children: [
          Text('Pagamento:'),
          Text(
            DateFormat('dd/MM/yyyy').format(debtor.datePay),
          ),
          // TextButton(
          //   onPressed: () {
          //     Provider.of<DebtorList>(context, listen: false).refreshDebtors();
          //   },
          //   child: Text('Teste.'),
          // )
        ],
      ),
    );
    // Container(
    //   child: Column(
    //     children: [
    //       Text(debtor.name),
    //       Text(debtor.number),
    //     ],
    //   ),
    // );
  }
}
