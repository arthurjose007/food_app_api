import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:food_app_api/models/model1.dart';

class Mealsprovider extends ChangeNotifier {
  static const apiEndpoint =
      'https://www.themealdb.com/api/json/v1/1/search.php?f=b';
  bool isloading = true;
  String error = '';
  Meals meals = Meals(meals: []);
  getDataFromApi() async {
    try {
      Response response = await http.get(Uri.parse(apiEndpoint));
      if (response.statusCode == 200) {
        meals = mealsFromJson(response.body);
        print(meals);
        //itemsFromJson(response.body);
      } else {
        error = response.statusCode.toString();
      }
    } catch (e) {
      error = e.toString();
    }
    isloading = false;
    notifyListeners();
  }
}
