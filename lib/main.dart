import 'package:aurora_take_home_paulo/data/repositories/image_repository.dart';
import 'package:aurora_take_home_paulo/view/app_view.dart';
import 'package:aurora_take_home_paulo/view/app_ctrl.dart';
import 'package:ctrl/ctrl.dart';
import 'package:flutter/material.dart';

void main() {
  Locator().registerFactory<ImageRepository>((i) => ImageRepositoryImpl());
  Locator().registerFactory<AppCtrl>((i) => AppCtrl(i()));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(colorScheme: .fromSeed(seedColor: Colors.deepPurple)),
      home: const AppView(),
    );
  }
}
