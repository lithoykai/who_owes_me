import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:who_owes_me/components/debtor_grid.dart';

import '../model/debtor_list.dart';
import '../utils/app_routers.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    Provider.of<DebtorList>(
      context,
      listen: false,
    ).listDebtors().then((value) => setState(
          () => _isLoading = false,
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Who owes me?'),
      ),
      body: DebtorGrid(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Provider.of<DebtorList>(context, listen: false).listDebtors();
          Navigator.of(context).pushNamed(AppRouters.ADD_FORM_PAGE);
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
