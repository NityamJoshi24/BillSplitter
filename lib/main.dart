import 'package:bill_splitter/repository/bill_view_repository_impl.dart';
import 'package:bill_splitter/view/home_view.dart';
import 'package:bill_splitter/viewmodel/bill_view_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(create: (_) => BillViewModel(BillViewRepositoryImpl()),
    child: MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomeView(),
    ),
    );
  }
}
