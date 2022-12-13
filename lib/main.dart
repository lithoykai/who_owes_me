import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:who_owes_me/components/debtor_grid.dart';
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

// class MyApp extends StatelessWidget {
//   const MyApp({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Flutter Demo',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//       ),
//       home: const MyHomePage(title: 'Flutter Demo Home Page'),
//       routes: {
//         AppRouters.ADD_FORM_PAGE: (ctx) => Add_Form_Page(),
//       },
//     );
//   }
// }

// class MyHomePage extends StatefulWidget {
//   const MyHomePage({Key? key, required this.title}) : super(key: key);

//   final String title;

//   @override
//   State<MyHomePage> createState() => _MyHomePageState();
// }

// class _MyHomePageState extends State<MyHomePage> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(widget.title),
//       ),
//       body: DebtorGrid(),
//       floatingActionButton: FloatingActionButton(
//         onPressed: () {
//           Navigator.of(context).pushNamed(AppRouters.ADD_FORM_PAGE);
//         },
//         tooltip: 'Increment',
//         child: const Icon(Icons.add),
//       ),
//       // This trailing comma makes auto-formatting nicer for build methods.
//     );
//   }
// }
