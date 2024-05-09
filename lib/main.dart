import 'package:flutter/material.dart';
import 'package:inventory_management_app/core/impl/sqliteDatabase.dart';
import 'package:inventory_management_app/core/impl/sqlite_repo.dart';
import 'package:inventory_management_app/home_screen.dart';
import 'package:inventory_management_app/logger/logger.dart';
import 'package:inventory_management_app/repo/category_repo/category_repo.dart';
import 'package:inventory_management_app/repo/product_repo/product_repo.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final sqldatabase = SqlliteDatabase.newInstance("abcdefg");
    final sqliteRepo sqlcategoryRepo = SqliteCategoryRepo(
      sqldatabase,
    );
    final SqlProductRepo sqlProductRepo = SqlProductRepo(sqldatabase);
    sqldatabase.connect().then((value) async {
      // final category =
      //     await sqlcategoryRepo.create(CategoryParams.create(name: "shoes"));
      // final re = await sqlcategoryRepo.findModel(useRef: true);
      // await sqlProductRepo.delete(4);
      // final product =
      //     await sqlProductRepo.update(1, CategoryParams.update(name: "mg mg"));

      // final re = await sqlProductRepo.find();
      // print("category $re");
      // final product = await sqlProductRepo.create(ProductParams.created(
      //     "${DateTime.now().toIso8601String()}  name",
      //     10,
      //     DateTime.now().toIso8601String()));
      // final reproductw =
      //     await sqlProductRepo.findModel(useRef: false, limit: 1);
      // final reproduct = await sqlProductRepo.findModel(useRef: true, limit: 1);
      final category = await sqlcategoryRepo.findModel(
        useRef: true,
      );

      logger.i("find category $category");
      // // print("find $reproductw");
      // print("find $reproduct");
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
