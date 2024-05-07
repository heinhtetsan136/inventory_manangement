import 'package:flutter/material.dart';
import 'package:inventory_management_app/core/impl/sqliteDatabase.dart';
import 'package:inventory_management_app/home_screen.dart';
import 'package:inventory_management_app/repo/category_entity.dart';
import 'package:inventory_management_app/repo/category_repo.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final sqldatabase = SqlliteDatabase.newInstance("sdfwdw");
    final SqlCategoryRepo sqlProductRepo = SqlCategoryRepo(sqldatabase);
    sqldatabase.connect().then((value) async {
      final product =
          await sqlProductRepo.create(CategoryParams.create(name: "w"));
      final re = await sqlProductRepo.find(3);
      // final product =
      //     await sqlProductRepo.update(1, CategoryParams.update(name: "mg mg"));
      final re1 = await sqlProductRepo.find(3);
      // final re = await sqlProductRepo.find();
      print("product $re $re1");
    });

    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a purple toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const Home(),
    );
  }
}
