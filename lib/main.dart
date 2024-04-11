import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:food_app_api/providers/foodprovider.dart';
import 'package:food_app_api/providers/mealsprovider.dart';
import 'package:food_app_api/views/bottom_navigation.dart';
import 'package:food_app_api/views/home.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => Mealsprovider()),
        ChangeNotifierProvider(create: (_) => FoodProvider()),
      ],
      child: MaterialApp(
          title: 'Flutter Demo',
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
            useMaterial3: true,
          ),
          home: bottomnavigation()
          // HomePage(),
          ),
    );
  }
}
