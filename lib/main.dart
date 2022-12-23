import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:who_owes_me/pages/add_formpage.dart';
import 'package:who_owes_me/pages/home_page.dart';
import 'package:who_owes_me/utils/app_routers.dart';

import 'model/debtor_list.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(
            create: (_) => DebtorList(),
          )
        ],
        child: MaterialApp(
          title: 'Flutter Demo',
          routes: {
            AppRouters.HOME_PAGE: (ctx) => HomePage(),
            AppRouters.ADD_FORM_PAGE: (ctx) => Add_Form_Page(),
          },
          debugShowCheckedModeBanner: false,
        ));
  }
}
