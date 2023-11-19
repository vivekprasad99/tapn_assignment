import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tapn_assignment/tapn/home/provider/home_provider.dart';
import 'package:tapn_assignment/tapn/splash/widget/splash_widget.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [ChangeNotifierProvider(create: (context) => HomeProvider())],
      child: MaterialApp(
        title: 'Mapbox Flutter',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(brightness: Brightness.light),
        darkTheme: ThemeData(brightness: Brightness.dark),
        themeMode: ThemeMode.dark,
        home: const Splash(),
      ),
    );
  }
}
