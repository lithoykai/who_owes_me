import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:who_owes_me/components/debtor_grid_item.dart';
import 'package:who_owes_me/model/debtor_list.dart';

import '../model/debtor.dart';

class DebtorGrid extends StatefulWidget {
  const DebtorGrid({Key? key}) : super(key: key);

  @override
  State<DebtorGrid> createState() => _DebtorGridState();
}

class _DebtorGridState extends State<DebtorGrid> {
  @override
  Widget build(BuildContext context) {
    @override
    void initState() {
      Provider.of<DebtorList>(context, listen: false).refreshDebtors;
    }

    @override
    void didUpdateWidget(oldWidget) {
      super.didUpdateWidget(oldWidget);
      if (widget != oldWidget) {
        Provider.of<DebtorList>(context, listen: false).dispose();
      }
    }

    final debtor = Provider.of<DebtorList>(context);
    Future<void> _refreshDebtors(BuildContext context) {
      return Provider.of<DebtorList>(context, listen: false).refreshDebtors();
    }

    var debtorList = debtor.items;

    return RefreshIndicator(
      onRefresh: () => _refreshDebtors(context),
      child: ListView.builder(
        itemBuilder: (ctx, i) => ChangeNotifierProvider.value(
          value: debtorList[i],
          child: DebtorGridItem(),
        ),
        // DebtorGridItem(debtor.items[i]),
        itemCount: debtor.itemsCount,
      ),
    );
  }
}
