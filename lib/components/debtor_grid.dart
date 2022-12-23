import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:who_owes_me/components/debtor_grid_item.dart';
import 'package:who_owes_me/model/debtor_list.dart';

class DebtorGrid extends StatefulWidget {
  const DebtorGrid({Key? key}) : super(key: key);

  @override
  State<DebtorGrid> createState() => _DebtorGridState();
}

class _DebtorGridState extends State<DebtorGrid> {
  @override
  Widget build(BuildContext context) {
    @override
    final debtor = Provider.of<DebtorList>(context);
    Future<void> _checkDebtorPayments(BuildContext context) {
      return Provider.of<DebtorList>(context, listen: false)
          .checkDebtorPayments();
    }

    var debtorList = debtor.items;

    return RefreshIndicator(
      onRefresh: () => _checkDebtorPayments(context),
      child: ListView.builder(
        itemBuilder: (ctx, i) => ChangeNotifierProvider.value(
          value: debtorList[i],
          child: DebtorGridItem(),
        ),
        itemCount: debtor.itemsCount,
      ),
    );
  }
}
