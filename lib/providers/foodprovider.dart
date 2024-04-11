import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:http/http.dart';
//import 'package:taskfromplacement/models/model1.dart';
import 'package:food_app_api/models/model2.dart';

class FoodProvider extends ChangeNotifier {
  static const apiEndpoints =
      'https://www.themealdb.com/api/json/v1/1/categories.php';
  bool isloading = true;
  String error = '';
  Categoryitem food = Categoryitem(categories: []);

  //foods = Foods(categories: []);
  getDataFromApi() async {
    try {
      Response response = await http.get(Uri.parse(apiEndpoints));
      if (response.statusCode == 200) {
        print("status code");
        food = categoryitemFromJson(response.body);
        print(food);
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
