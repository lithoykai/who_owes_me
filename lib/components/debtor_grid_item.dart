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
  bool _listOptions = false;
  // Debtor debtor;
  @override
  Widget build(BuildContext context) {
    final debtor = Provider.of<Debtor>(
      context,
      listen: false,
    );
    return Column(
      children: [
        ListTile(
          onTap: () {
            setState(() {
              _listOptions = !_listOptions;
            });
          },
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5),
          ),
          tileColor: debtor.paymentColor!,
          title: Text(debtor.name),
          subtitle: Text('${debtor.number} - R\$ ${debtor.valuePay}'),
          trailing: Column(
            children: [
              Text('Pagamento:'),
              Text(
                DateFormat('dd/MM/yyyy').format(debtor.datePay),
              ),
            ],
          ),
        ),
        _listOptions
            ? Container(
                color: debtor.paymentColor,
                padding: EdgeInsets.symmetric(horizontal: 9, vertical: 6),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextButton(
                      onPressed: () {},
                      child: Text('Mandar mensagem.'),
                    ),
                    TextButton(
                      onPressed: () {
                        Provider.of<DebtorList>(context, listen: false)
                            .paymentDone(debtor)
                            .then((value) =>
                                Provider.of<DebtorList>(context, listen: false)
                                    .listDebtors());
                      },
                      child: Text('Realizar pagamento.'),
                    ),
                  ],
                ))
            : Container(),
      ],
    );
  }
}
